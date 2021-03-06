require 'json'

#
# Simple client for Ideone API 1.1.11
#

class IdeoneClient
 
  attr_accessor :user, :password, :endpoint, :namespace, :patience

  def initialize(user, password)
    @user = user
    @password = password
    @endpoint = "http://www.ideone.com/api/1/service"
    @namespace = "http://www.ideone.com/api/1/service"
    @patience = 10
    @client = create_soap_client
  end

  def run_code(src, input = "", lang = 'c')
    response = create_submission(src, input, lang) 
    parse(response, :create_submission_response, :link)
  end

  def get_code_results(link)
    response = wait_for_submission_status_response(link)
    result_code = parse(response, :get_submission_status_response, :result)
    create_detailed_result(link, result_code)
  end

  private

  attr_reader :client

  def create_soap_client
    @client = Savon::Client.new do |wsdl|
      wsdl.endpoint = endpoint 
      wsdl.namespace = namespace 
    end
  end

  def create_submission(src, input, lang)
    response = client.request :create_submission do
      soap.body = {:user=> user,
                   :pass=> password,
                   :source_code=> src,
                   :language=> to_id(lang),
                   :input=>input,
                   :run=>true,
                   :private=>true,
                   :order! => [:user,:pass,:source_code,:language,:input,:run,:private]}
    end
  end

  def wait_for_submission_status_response(link)
    waited = 0
    begin
      waited += sleep(3)
      response = get_submission_status(link)
      status = parse(response, :get_submission_status_response, :status)
    end while not program_finished?(status) and waited < patience

    out_of_patience = (!program_finished?(status)) and waited > patience 
    raise "The response timed out! Waited for #{patience} seconds" if out_of_patience

    response
  end

  def get_submission_status(link)
    response = client.request :get_submission_status do
      soap.body = {:user=>user,
                  :pass=>password,
                  :link=>link}
    end
  end

  def create_detailed_result(link, result_code)
    response = get_submission_details(link)
    {:output => parse(response, :get_submission_details_response, :output),
     :memory => parse(response, :get_submission_details_response, :memory).to_i,
     :time   => parse(response, :get_submission_details_response, :time).to_f,
     :error  => get_error_message(result_code)}
  end

  def get_submission_details(link)
    response = client.request :get_submission_details do 
      soap.body = {:user => user,
                   :pass => password,
                   :link => link,
                   :with_input=>true,
                   :with_output=>true}
    end
  end

  def program_finished?(status)
    #
    # According to the Ideone API 1.1.11 documentation http://ideone.com/files/ideone-api.pdf
    #
    # status < 0 waiting for compilation – the paste awaits execution in the queue 
    # status == 0 done – the program has finished compilation – the program is being compiled
    # status == 3 running – the program is being executed
    #
    status.to_i == 0
  end

  #
  # According to the Ideone API 1.1.11 documentation http://ideone.com/files/ideone-api.pdf
  #
  # 0 not running – the paste has been created with run parameter set to false
  # 11 compilation error  – the program could no be executed due to compilation errors
  # 12 runtime   error   –   the   program   finished because of  the runtime error, for example: division by zero,  array index out of bounds, #uncaught exception
  # 13 time  limit  exceeded  –  the  program  didn't #stop before the time limit
  # 15 success – everything went ok
  # 17 memory limit exceeded – the program tried #to use more memory than it is allowed
  # 19 illegal system call – the program tried to call #illegal system function
  # 20 internal error – some problem occurred on #ideone.com; try to submit the paste again #and if that fails too, then please contact us
  #
 
  # Returns a symbol describing the error
  #     :compile_error - The program didn't compile.
  #     :runtime_error - A runtime error occured (e.g. Seg Fault).
  #     :timeout_error - The program ran for too long
  #     :memory_error  - The program used too much memory 
  #     :syscall_error - The program mad an illegal system call
  #
  #
  def get_error_message(result_code)
    case 
      when compile_error?(result_code) then :compile_error
      when runtime_error?(result_code) then :runtime_error
      when timeout_error?(result_code) then :timeout_error
      when memory_error?(result_code)  then :memory_error
      when syscall_error?(result_code) then :syscall_error
    end
  end

  def program_completed_successfully?(result_code)
    result_code.to_i == 15 
  end
  
  def program_compiled?(result_code)
    result_code.to_i != 11
  end

  def compile_error?(result_code)
    result_code.to_i == 11
  end

  def runtime_error?(result_code)
    result_code.to_i == 12 
  end

  def timeout_error?(result_code)
    result_code.to_i == 13
  end

  def memory_error?(result_code)
    result_code.to_i == 17 
  end

  def syscall_error?(result_code)
    result_code.to_i == 19
  end

  def to_id(lang)
    #
    # TODO: Implement more lang=>id languages. Right now this
    # only supports C.
    #
    11
  end

  def parse(response, action, key)
    #
    # Note: As of API 1.1.11, an empty string is represented in the response.to_hash 
    # as an item with {value:{"type":"xsd:string"}, key:"output/input"}. Therefore
    # if the item value is not a string, we will just return the empty string. 
    #
    raise_if_not_parsable(response, action) 
    items_hash_array = response.to_hash[action][:return][:item]
    item = items_hash_array.detect {|item| item[:key].to_sym == key.to_sym}
    raise "Response did not include a #{key.to_sym} key" unless item and item[:value]
    item[:value].is_a?(String) ? item[:value] : ""
  end

  def raise_if_not_parsable(response, action)
    rhash = response.to_hash
    raise "no xml path: #{action} return" unless rhash[action] and rhash[action][:return]
    items = rhash[action][:return][:item]
    raise "return node not an array" unless items.instance_of?(Array)
    items.each do |h|
      raise "Item child is not a hash" unless h.instance_of?(Hash)
    end
  end
end
