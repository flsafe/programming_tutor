require 'yaml'

class GradeSheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise 

  validates :user, :exercise, :src_code, :tests, :grade, :presence=>true
  validate :unit_tests_format

  before_validation :grade, :serialize_unit_tests

  # Returns all the grades for the
  # given user.
  def self.grades_for(user)
    grade_sheets = GradeSheet.where(:user_id => user).order('grade')
    grade_sheets.inject({}) {|accum, gs| accum.merge!(gs.exercise.id => gs.grade)}
  end

  # Return the lesson that this grade sheet is associated with
  def lesson
    exercise.lesson
  end

  # Returns the users XP stats sheet
  def user_stats_sheet
    user.stats_sheet
  end

  # Returns the exercises XP stats sheet
  def exercise_stats_sheet
    exercise.stats_sheet 
  end
  
  # Add a hash describing the results of a unit test.
  # The keys are:
  #
  #     {:test_name=>{:input, :output, :expected, :points}}
  #
  # The points key is optional and will be calculated
  # automatically if left out.
  def add_unit_test(unit_test_hash)
    unit_tests.merge!(unit_test_hash)
  end

  # Return the grade
  def grade
    self[:grade] ||= calc_grade
  end

  # Returns the unit test hashes that have been
  # added to this unit test.
  def unit_tests 
    @tests_hash = @tests_hash || YAML.load(tests || "") || {}
  end

  # Returns the points per test
  def default_points_per_test
    100.0 / unit_tests.count
  end

  def unit_tests_failed?
    not unit_tests_ok?
  end

  def unit_tests_ok?
    unit_tests_format
    not errors.any?
  end

  private 

  # Calculate the grade based on the 
  # unit test hashes that have been added
  # to this grade sheet.
  def calc_grade
    @sum = 0
    unit_tests.each_pair do |test_name, info|
      if info[:output] and (info[:output].strip.chomp == info[:expected].strip.chomp)
        info[:points] = default_points_per_test unless info[:points]
        @sum += info[:points] 
      else
        @sum += (info[:points] = 0)
      end
    end
    @sum 
  end

  # Validates each unit test result hash.
  # Each unit test result hash must have the 
  # expected keys.
  #     :input, :output, :expected, :points
  def unit_tests_format
    expected_keys = [:input, :output, :expected]
    if unit_tests.empty?
      errors.add(:base, "There was an error when trying to execute the unit tests")
    else
      unit_tests.each_pair do |test_name, info|
        expected_keys.each do |expected_key|
          errors.add(:base, "'#{test_name}' is missing #{expected_key}") unless info[expected_key]
        end
      end
    end
  end

  def serialize_unit_tests
    self.tests = YAML.dump(unit_tests)
  end
end
