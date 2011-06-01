require 'yaml'

class GradeSheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise 

  validates :user, :exercise, :src_code, :tests, :presence=>true
  validate :unit_tests_format

  before_validation :serialize_unit_tests

  # Returns the latest grade sheet
  # for the user's current exercise.
  def self.for(user)
    curr_exercise = user.current_exercise
    GradeSheet.where(:user_id => user.id, 
                     :exercise_id => curr_exercise.id).order("created_at DESC").first
  end

  # Calculate the grade based on the 
  # unit test hashes that have been added
  # to this grade sheet.
  def grade
    unit_tests.each_pair do |test_name, info|
      info[:points] ||= default_points_per_test
    end
    @sum = 0
    unit_tests.each_pair do |test_name, info|
      if info[:output] and (info[:output].strip.chomp == info[:expected].strip.chomp)
        @sum += info[:points] 
      end
    end
    @sum
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
