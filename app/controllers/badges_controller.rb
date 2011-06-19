class BadgesController < ApplicationController

  before_filter :require_admin, :except=>[:index, :show]

  # GET /badges
  # GET /badges.xml
  def index
    if current_user.admin?
      @badges = Badge.all
    else
      @badges = Badge.finished
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @badges }
    end
  end

  # GET /badges/1
  # GET /badges/1.xml
  def show
    @badge = Badge.find(params[:id])
    if not @badge.finished? and not current_user.admin?
      redirect_to home_url
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @badge }
    end
  end

  # GET /badges/1/edit
  # DELETE /badges/1
  # DELETE /badges/1.xml
  def destroy
    @badge = Badge.find(params[:id])
    @badge.destroy

    respond_to do |format|
      format.html { redirect_to(badges_url) }
      format.xml  { head :ok }
    end
  end
end
