class StatsSheetsController < ApplicationController

  before_filter :require_non_anonymous_user
  before_filter :require_admin, :except=>[:index, :show]
  
  # GET /stats_sheets
  # GET /stats_sheets.xml
  def index
    @stats_sheets = StatsSheet.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stats_sheets }
    end
  end

  # GET /stats_sheets/1
  # GET /stats_sheets/1.xml
  def show
    @stats_sheet = params[:id] == "me" ? current_user.stats_sheet : StatsSheet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stats_sheet }
    end
  end

  # GET /stats_sheets/1/edit
  def edit
    @stats_sheet = StatsSheet.find(params[:id])
  end

  # PUT /stats_sheets/1
  # PUT /stats_sheets/1.xml
  def update
    @stats_sheet = StatsSheet.find(params[:id])

    respond_to do |format|
      if @stats_sheet.update_attributes(params[:stats_sheet])
        format.html { redirect_to(@stats_sheet, :notice => 'Stats sheet was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stats_sheet.errors, :status => :unprocessable_entity }
      end
    end
  end
end
