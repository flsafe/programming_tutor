# Represents what exercise the user is
# currently working on.

class CodeSession < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise

  validates :user, :exercise, :presence=>true

  CHECK_RATE = 25 # Seconds between solution checks

  # Returns true if the user can make another solution check.
  def self.within_rate?(last_check_time)
    if last_check_time
      Time.now - last_check_time >= CodeSession::CHECK_RATE
    else
      true
    end
  end
end
