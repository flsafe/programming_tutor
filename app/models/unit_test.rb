class UnitTest < ActiveRecord::Base
  belongs_to :exercise

  validates :src_code, :src_language, :presence=>true

  include UnitTestDriver

  MSGS = {
    :invalid_unit_test => "Aww, shoot! An internal error occured. Specifically, the unit test for your exercise crashed. Sorry! Try again a bit later."
  }

  # Fill out attributes using an uploaded code file field.
  def uploaded_unit_test=(unit_test_field)
     self.src_code = unit_test_field.read
     self.src_language = "ruby"
  end

  # Call each method unit test method with
  # the given solution code.
  def run_with(solution_code)
    @grade_sheet = GradeSheet.new(:src_code=>solution_code)
    begin
      class_eval src_code
    rescue
      Rails.logger.error "The unit test could not be evaluated:\n #{src_code}"
      @grade_sheet.errors.add(:base, MSGS[:invalid_unit_test])
    end
    drive_unit_tests
    @grade_sheet
  end
end
