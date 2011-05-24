class UnitTest < ActiveRecord::Base
  belongs_to :exercise

  validates :src_code, :src_language, :presence=>true

  include UnitTestDriver

  # Fill out attributes using an uploaded code file field.
  def uploaded_unit_test=(unit_test_field)
     self.src_code = unit_test_field.read
     self.src_language = "ruby"
  end

  # Call each method unit test method with
  # the given solution code.
  def run_with(solution_code)
    @grade_sheet = GradeSheet.new(:src_code=>solution_code)
    class_eval src_code
    drive_unit_tests
    @grade_sheet
  end
end
