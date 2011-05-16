class UnitTest < ActiveRecord::Base

  belongs_to :exercise

  def uploaded_unit_test=(unit_test_file_field)
     src_language = "ruby"
     src_code = unit_test_file_field.read
  end
end
