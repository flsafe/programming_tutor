class Exercise < ActiveRecord::Base
  default_scope :order=>'title'

  has_many :hints, :dependent=>:destroy
  has_one :unit_test, :dependent=>:destroy
  has_one :solution_template, :dependent=>:destroy

  accepts_nested_attributes_for :hints
  accepts_nested_attributes_for :unit_test
  accepts_nested_attributes_for :solution_template

  validates :title, :presence=>true
  validates :minutes, :numericality=>{:greater_than_or_equal_to=>1}
end
