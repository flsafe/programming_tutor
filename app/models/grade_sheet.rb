require 'yaml'

class GradeSheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise 

  validates :user, :exercise, :src_code, :tests, :presence=>true
  validate :unit_tests_format

  # Calculate the grade based on the 
  # unit test hashes that have been added
  # to this grade sheet.
  def grade
    @sum = 0
    unit_tests.each_pair do |test_name, info|
      @sum += info[:points] 
    end
  end
  
  # Add a hash describing the results of a unit test.
  # The keys are:
  #
  #     {:test_name=>{:input, :got, :expected, :points}}
  #
  # The points key is optional and will be calculated
  # automatically if left out.
  def add_unit_test(unit_test_hash)
    unit_test_hash.each_pair do |test_name, info|
      info[:points] ||= default_points_per_test
    end
    unit_tests.merge(unit_test_hash)
    tests = YAML.dump(unit_tests)
  end

  # Returns the unit test hashes that have been
  # added to this unit test.
  def unit_tests 
    @tests_hash = @tests_hash || {}
  end

  # Returns the points per test
  def default_points_per_test
    100.0 / unit_tests.count
  end

  private 

  # Validates each unit test result hash.
  def unit_tests_format
    expected_keys = [:input, :got, :expected, :points]
    unit_tests.each_pair do |test_name, info|
      expected_keys.each do |expected_key|
        errors.add(:base, "'#{test_name}' is missing #{expected_key}") unless info[expected_key]
      end
    end
  end

end
