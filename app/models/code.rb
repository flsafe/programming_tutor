# Tableless model representing the code
# the user types into the text editor when
# solving an exercise.
class Code < ActiveRecord::Base

  # Run the code through a syntax check.
  # Returns the compiler's syntax check output
  # message.
  def get_syntax_message
    Compiler.get_syntax_message(src_code)
  end

  # Runs the code against the given unit test
  # using the provided solution template. 
  def check_against(unit_test, solution_template)
    solution = solution_template.fill_in(src_code)  
    grade_sheet = unit_test.run_with(solution)
    Feedback.on(grade_sheet)
  end

  # Tableless model
  def self.columns() @columns ||= []; end  
   
  def self.column(name, sql_type = nil, default = nil, null = true)  
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)  
  end  

  column :src_code, :text    
end
