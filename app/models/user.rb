class User < ActiveRecord::Base

  has_one :code_session, :dependent=>:destroy

  # Used to make random strings
  @@CHAR_TAB =  %w{ 1 2 3 4 6 7 9 A B C D E F G H I J K L M N P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z _ -}

  acts_as_authentic do |c|
    # for available options see documentation in: Authlogic::ActsAsAuthentic
    # c.my_config_option = my_value 
  end 

  attr_accessible :username, :email, :password, :password_confirmation

  # The user is going to start coding this exercise.
  # Creates a new code session.
  def start_coding(exercise)
    unless code_session
      self.code_session = CodeSession.new(:exercise=>exercise)
    end
  end

  # The user is no longer doing an exercise.
  # Destroys the current code session. Does
  # nothing if the user doesn't have a code session.
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

  # Returns the number of seconds left in the coding session
  # or nill of the user isn't doing an exercise.
  def seconds_left_in_code_session
    if code_session 
      start_time = code_session.created_at 
      end_time = start_time + current_exercise.minutes * 60#secs/min
      elapsed_seconds = (end_time - Time.now).ceil
      elapsed_seconds >= 0 ? elapsed_seconds : 0
    end
  end

  # Create an anonymous user with a random user name
  # and a random password. It is supposed to be a one time use
  # to try the app out without registering.
  def self.new_anonymous
    size = @@CHAR_TAB.size 
    rand_password = (0..32).map { @@CHAR_TAB[rand(size)] }.join
    rand_sufix = (0..5).map { @@CHAR_TAB[rand(size)] }.join
    User.new do |u|
      u.username = "user" + rand_sufix
      u.password = rand_password
      u.password_confirmation = rand_password
      u.email = u.username + "@example.com"
      u.anonymous = true
    end
  end
end
