class UsersController < ApplicationController

  before_filter :require_non_anonymous_user, :except=> [:new, :create]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save && 
      UserSession.create(:username => @user.username, :password => @user.password)
        flash[:notice] = "You are registered! Welcome to PrepCode!"
        redirect_to home_path 
    else
      render :action => :new
    end
  end
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end


