# Represents what exercise the user is
# currently working on.

class CodeSession < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise

  validates :user, :exercise, :presence=>true

  CHECK_RATE = 20 # Seconds between solution checks
  GRADE_RATE = 20 # Seconds between grading solutions

  def self.grade_within_rate?(last_grade_time)
    if last_grade_time
      Time.now - last_grade_time >= CodeSession::GRADE_RATE
    else
      true
    end
  end

  def self.check_within_rate?(last_check_time)
    if last_check_time
      Time.now - last_check_time >= CodeSession::CHECK_RATE
    else
      true
    end
  end
end
