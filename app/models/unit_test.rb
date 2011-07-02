
# Represents the unit tests used to grade a user's
# solution.

class UnitTest < ActiveRecord::Base
  belongs_to :exercise

  validates :src_code, :src_language, :presence=>true

  @@PROTOTYPE_REGEX = /\/\*start_prototype\*\/(.*)\/\*end_prototype\*\//m

  # Fill out attributes using an uploaded file field.
  def uploaded_unit_test=(unit_test_field)
     self.src_code = unit_test_field.read
     self.src_language = "c"
  end

  # Execute the unit tests on the solution code
  # and return a grade sheet describing the results
  # of the unit test.
  def execute(solution_snippet)
    solution_snippet.gsub!(/\\/, '\\\\\\\\')
    @grade_sheet = GradeSheet.new()
    solution_code = fill_in_with(solution_snippet) 
    if Compiler.syntax_error?(solution_snippet) || Compiler.syntax_error?(solution_code)
      @grade_sheet.errors.add(:base, "Your solution doesn't compile!")
    else
      @result = exec_unit_test(solution_code)
      if @result[:error] 
        set_grade_sheet_errors
      else
        @grade_sheet.add_unit_test(@result[:output])
      end
    end
    @grade_sheet
  end

  # Returns the code between the
  # start_prototye and end_prototype markers
  # in the template src_code. 
  def prototype 
    m = src_code.match(@@PROTOTYPE_REGEX)
    if m and m[1]
      m[1].strip.chomp
    else
      ""
    end
  end

  private

  # Fill in the solution tempalte with the user's solution.
  def fill_in_with(solution_snippet)
    src_code.gsub(@@PROTOTYPE_REGEX, solution_snippet).strip.chomp
  end

  # Set a message for the different types of errors.
  def set_grade_sheet_errors
    if @result[:error] == :timeout_error
      @grade_sheet.errors.add(:base, "Your solution didn't finish on time!")
    elsif result[:error]
      @grade_sheet.errors.add(:base, "Sorry! An internal error occured. We're working on it!")
    end
  end

  def exec_unit_test(solution_code)
    client = IdeoneClient.new(APP_CONFIG['ideone']['user'], APP_CONFIG['ideone']['password'])
    begin
      link = client.run_code(solution_code)
      results = client.get_code_results(link)
      parse_result_output(results)
    rescue => e 
      Rails.logger.error("There was an error when attempting to reach the Ideone server.")
      Rails.logger.error(e.message)
      {:error=>:ideone_not_reached,
       :output=>{}}
    end
  end

  def parse_result_output(ideone_client_results)
    ideone_client_results[:output] = (YAML.load(ideone_client_results[:output] || "") || {}).with_indifferent_access
    ideone_client_results
  end
end
