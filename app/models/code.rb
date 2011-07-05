# Tableless model representing the code
# the user types into the text editor when
# solving an exercise.

class Code < ActiveRecord::Base

  # Run the code through a syntax check.
  # Returns the compiler's output message.
  def get_syntax_message
    Compiler.get_syntax_message(src_code)
  end

  # Runs the code against the given unit test
  # and solution template. Returns
  # a string containing a short feedback message. Does
  # not record a grade.
  def check_against(unit_test)
    grade_sheet = unit_test.execute(src_code)  
    Feedback.on(grade_sheet)
  end

  # Grades the code against the unit test using
  # and solution template. Returns
  # a valid grade sheet if no errors occured while
  # grading the solution. If an error occured then
  # it returns an invalid grade sheet with the errors array
  # explaining why.
  def grade_against(unit_test, user)
    grade_sheet = unit_test.execute(src_code)
    if grade_sheet.errors.any?
      log_grade_sheet_errors(grade_sheet)
    else
      grade_sheet.src_code = src_code
      grade_sheet.user = user
      grade_sheet.exercise = user.current_exercise
      grade_sheet.lesson = user.current_exercise.lesson
      grade_sheet.course = user.current_exercise.lesson.course
      unless grade_sheet.save
        log_grade_sheet_errors(grade_sheet)
      end
    end
    grade_sheet
  end

  def log_grade_sheet_errors(grade_sheet)
      Rails.logger.error "Invalid grade sheet could not be saved:\n "
      grade_sheet.errors.full_messages.each {|msg| Rails.logger.error msg}
  end

  # Tableless model
  def self.columns() @columns ||= []; end  
   
  def self.column(name, sql_type = nil, default = nil, null = true)  
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)  
  end  

  column :src_code, :text    
end
