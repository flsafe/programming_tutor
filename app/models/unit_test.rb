class UnitTest < ActiveRecord::Base
  belongs_to :exercise

  validates :src_code, :src_language, :presence=>true

  def uploaded_unit_test=(unit_test_field)
     self.src_code = unit_test_field.read
     self.src_language = "ruby"
  end
end
