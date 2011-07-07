require 'yaml'

# Represents the grade and other info
# about the user's solution.

class GradeSheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise 
  belongs_to :lesson
  belongs_to :course

  validates :user, :exercise, :lesson, :course, :tests, :grade, :presence=>true
  validate :unit_tests_format

  before_validation :grade

  # Returns all the grades for the
  # given user in a hash with exercise_ids as keys
  # and the grade for the exercise as values.
  def self.grades_for(user)
    grade_sheets = GradeSheet.where(:user_id => user).includes(:exercise).select("exercise.id").order('grade').group('exercises.id')
    grade_sheets.inject({}) {|accum, gs| accum.merge!(gs.exercise.id => gs.grade)}
  end

  # Returns the users XP stats sheet.
  def user_stats_sheet
    user.stats_sheet
  end

  # Returns the exercise's XP stats sheet.
  # This sheet describes how much XP completing the 
  # exercise is worth.
  def exercise_stats_sheet
    exercise.stats_sheet 
  end
  
  # Add a hash describing the results of a unit test.
  # The keys are:
  #
  #     {"Test Name"=>{:input=>'a', :output=>'a', :expected=>'a', :points=>'100'}}
  #
  # The points key is optional and will be calculated
  # automatically if left out.
  def add_unit_test(new_unit_test)
    unit_tests.merge!(new_unit_test)
    self.tests = YAML.dump(unit_tests)
  end

  # Returns the grade the user got based on the
  # results of the unit tests.
  def grade
    self[:grade] ||= calc_grade
  end

  # Returns the unit test hashes that have been
  # added to this unit test merged into one.
  def unit_tests 
    @tests_hash = @tests_hash || (YAML.load(tests || "") || {}).with_indifferent_access
  end

  # Returns the points per test.
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

  def self.new_for_user(user)
    grade_sheet = GradeSheet.new
    grade_sheet.user = user
    grade_sheet.lesson = user.current_lesson 
    grade_sheet.course = user.current_course 
    grade_sheet.exercise = user.current_exercise
    grade_sheet
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
        @sum += info[:points].to_f
      else
        @sum += (info[:points] = 0.0)
      end
    end
    @sum 
  end

  # Validates each unit test result hash.
  # Each unit test result hash must have the 
  # these keys.
  #     :input, :expected
  # Can have:
  #     :output, :error
  def unit_tests_format
    expected_keys = [:input, :expected]
    if unit_tests.empty?
      errors.add(:base, "The grade sheet can not be saved with empty unit tests")
    else
      unit_tests.each_pair do |test_name, info|
        expected_keys.each do |expected_key|
          errors.add(:base, "'#{test_name}' is missing #{expected_key}") unless info[expected_key]
        end
      end
    end
  end
end
