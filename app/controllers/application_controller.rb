class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user_session, :current_user

  before_filter :create_anonymous_if_no_user
  
  protected 

  def current_user_session
    return @current_user_session if defined?(@current_user_session) && !@current_user_session.nil?
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user) && !@current_user.nil?
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
    unless current_user
      store_location
      redirect_to new_user_session_url, :notice=>"You have to be logged in!"
      return false
    end
  end

  def require_non_anonymous_user
    if current_user == nil || current_user.anonymous?
      redirect_to home_url, :notice=>"You have to be logged in!"
    end
  end

  def create_anonymous_if_no_user 
    unless current_user_session
      anonymous_user = User.new_anonymous
      # The random user name might be taken.
      # Try a few times to find one that isn't taken.
      5.times { return if anonymous_user.save }

      # Couldn't find an unused user name.
      # How likely is it that this would happen?
      # The random username suffix has 5^64 possibilities. Until
      # we start getting millions of users I don't think this will 
      # happen?
      Rails.logger.error "The anonymous user couldn't be saved!"
      anonymous_user.errors.full_messages.each {|msg| Rails.logger.error msg}
      raise "Can't create anonymous account!"
    end
  end

  def require_no_user
    if current_user.anonymous? == false
      store_location
      redirect_to account_url, :notice=>"You have to be logged in!"
      return false
    end
  end

  def require_admin
    if current_user == nil || current_user.admin? == false || current_user.anonymous?
      store_location
      redirect_to home_url
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end

