class GradeSheetsController < ApplicationController
  # GET /grade_sheets
  # GET /grade_sheets.xml
  def index
    @grade_sheets = GradeSheet.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grade_sheets }
    end
  end

  # GET /grade_sheets/1
  # GET /grade_sheets/1.xml
  def show
    @grade_sheet = GradeSheet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grade_sheet }
    end
  end

  # GET /grade_sheets/new
  # GET /grade_sheets/new.xml
  def new
    @grade_sheet = GradeSheet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grade_sheet }
    end
  end

  # GET /grade_sheets/1/edit
  def edit
    @grade_sheet = GradeSheet.find(params[:id])
  end

  # POST /grade_sheets
  # POST /grade_sheets.xml
  def create
    @grade_sheet = GradeSheet.new(params[:grade_sheet])

    respond_to do |format|
      if @grade_sheet.save
        format.html { redirect_to(@grade_sheet, :notice => 'Grade sheet was successfully created.') }
        format.xml  { render :xml => @grade_sheet, :status => :created, :location => @grade_sheet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grade_sheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /grade_sheets/1
  # PUT /grade_sheets/1.xml
  def update
    @grade_sheet = GradeSheet.find(params[:id])

    respond_to do |format|
      if @grade_sheet.update_attributes(params[:grade_sheet])
        format.html { redirect_to(@grade_sheet, :notice => 'Grade sheet was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grade_sheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /grade_sheets/1
  # DELETE /grade_sheets/1.xml
  def destroy
    @grade_sheet = GradeSheet.find(params[:id])
    @grade_sheet.destroy

    respond_to do |format|
      format.html { redirect_to(grade_sheets_url) }
      format.xml  { head :ok }
    end
  end
end
