class NotificationsController < ApplicationController
  # GET /notifications
  # GET /notifications.xml
  def index
    @notifications = Notification.for_user(current_user)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notifications }
    end
  end

  # GET /notifications/1
  # GET /notifications/1.xml
  def show
    @notification = Notification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @notification }
    end
  end
end
