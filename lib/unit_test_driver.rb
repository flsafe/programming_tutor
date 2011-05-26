require 'json'
require 'ideone_client'

# Mixin for UnitTest. Executes all functions
# whose names begin with the string "test".
# Records the results in the instance method @grade_sheet.

module UnitTestDriver
  
  # Invoke the methods whose names begin with
  # the string 'test_'. It's expected that
  # each of these test methods call
  # 'run_with_and_expect'.
  def drive_unit_tests 
    @mutex = Mutex.new
    threads = public_methods.select{|m| m =~ /^test_/}.map do |method_name|
       Thread.new(method_name) {|m| send(m)}
    end
    threads.each {|thr| thr.join}
  end
  
  # Execute the program 'input' and compare its standard output to 
  # the string 'expected'. This test is worth 'points' if the standard output
  # and 'expected' match.
  def run_with_and_expect(input, expected, points = nil)
   results = execute(@grade_sheet.src_code, input)
   unit_test_results = {test_name => {:input    => input,
                                      :expected => expected, 
                                      :points   => points}.merge!(results)}
   @mutex.lock
     @grade_sheet.add_unit_test(unit_test_results)
   @mutex.unlock
  end
  
  private

  # Used to determine what to call the current test. 
  # The name is extracted from the caller of 'run_with_and_expect'. 
  def test_name 
    Kernel.caller.each do | callr |
      caller_m = callr.match(/`(test_.+)'/)
      return humanize( caller_m[1] ) if caller_m and caller_m[1]
    end
    "Test case"
  end

  # Used to make a unit test method name look pretty.
  def humanize(str)
    str.gsub(/_/,' ').gsub(/test/, "").strip.capitalize
  end

  # Execute the given src code.
  def execute(src_code, input)
    client = IdeoneClient.new(APP_CONFIG['ideone']['user'], APP_CONFIG['ideone']['password'])
    link = client.run_code(src_code, input)
    results = client.get_code_results(link)
  end
end
