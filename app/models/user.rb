class User < ActiveRecord::Base

  has_one :code_session, :dependent=>:destroy

  acts_as_authentic do |c|
    # for available options see documentation in: Authlogic::ActsAsAuthentic
    # c.my_config_option = my_value 
  end 

  attr_accessible :username, :email, :password, :password_confirmation

  # The user is going to start coding this exercise.
  def start_coding(exercise)
    unless code_session
      self.code_session = CodeSession.new(:exercise=>exercise)
    end
  end

  # The user is no longer doing this exercise.
  def end_code_session
    if code_session
      code_session.destroy
      self.code_session = nil
    end
  end

  # Returns the exercise the user is currently doing.
  def current_exercise
    if code_session
      code_session.exercise
    end
  end

  # Returns the number of seconds left in the coding session.
  # Calculated as 
  def seconds_left_in_code_session
    if code_session 
      start_time = code_session.created_at 
      end_time = start_time + current_exercise.minutes * 60#secs/min
      elapsed_seconds = (end_time - Time.now).ceil
      elapsed_seconds >= 0 ? elapsed_seconds : 0
    end
  end
end
