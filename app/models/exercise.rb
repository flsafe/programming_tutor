class Exercise < ActiveRecord::Base

  include Statistics

  default_scope :order=>'title'

  belongs_to :lesson

  has_one :unit_test, :dependent=>:destroy
  has_one :solution_template, :dependent=>:destroy

  has_many :hints, :dependent=>:destroy
  has_many :grade_sheets, :dependent=>:destroy

  has_many :code_sessions

  accepts_nested_attributes_for :hints, :unit_test, :solution_template

  validates :title, :unit_test, :solution_template, :presence=>true
  validates :minutes, :numericality=>{:greater_than_or_equal_to=>1}

  def prototype
    return solution_template.prototype
  end
end
