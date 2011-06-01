class UserSessionsController < ApplicationController
  
  before_filter :require_no_user, :only => [:new, :create]
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
  
  def destroy
    if current_user
      current_user_session.destroy
      flash[:notice] = "Logout successful!"
    end
    redirect_to home_url
  end
end

