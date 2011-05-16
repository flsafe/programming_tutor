class SolutionTemplate < ActiveRecord::Base
  belongs_to :exercise

  def uploaded_solution_template=(unit_test_field)
    src_language = 'c'
    src_code = unit_test_field.read
  end
end
