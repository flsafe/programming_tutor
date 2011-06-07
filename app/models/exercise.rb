# Represents an exercise the user can
# practice with.

class Exercise < ActiveRecord::Base

  include Statistics

  default_scope :order=>'title'

  belongs_to :lesson

  has_one :unit_test, :dependent=>:destroy
  has_one :solution_template, :dependent=>:destroy
  has_one :stats_sheet, :as=>:xp, :dependent=>:destroy
  after_initialize lambda {|e|e.stats_sheet = StatsSheet.new unless e.stats_sheet}

  has_many :hints, :dependent=>:destroy
  has_many :grade_sheets, :dependent=>:destroy
  has_many :code_sessions

  accepts_nested_attributes_for :hints, :unit_test, :solution_template

  validates :title, :unit_test, :solution_template, :presence=>true
  validates :minutes, :numericality=>{:greater_than_or_equal_to=>1}

  # Returns a template for the
  # user's solution. Usually displayed in
  # a text editor.
  def prototype
    return solution_template.prototype
  end
end
