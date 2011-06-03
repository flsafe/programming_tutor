require 'spec_helper'

describe StatsSheetsController do

  # This should return the minimal set of attributes required to create a valid
  # StatsSheet. As you add validations to StatsSheet, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all stats_sheets as @stats_sheets" do
      stats_sheet = StatsSheet.create! valid_attributes
      get :index
      assigns(:stats_sheets).include?(stats_sheet).should == true
    end
  end

  describe "GET show" do
    it "assigns the requested stats_sheet as @stats_sheet" do
      stats_sheet = StatsSheet.create! valid_attributes
      get :show, :id => stats_sheet.id.to_s
      assigns(:stats_sheet).should eq(stats_sheet)
    end
  end

  describe "GET edit" do
    it "assigns the requested stats_sheet as @stats_sheet" do
      stats_sheet = StatsSheet.create! valid_attributes
      get :edit, :id => stats_sheet.id.to_s
      assigns(:stats_sheet).should eq(stats_sheet)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested stats_sheet" do
        stats_sheet = StatsSheet.create! valid_attributes
        # Assuming there are no other stats_sheets in the database, this
        # specifies that the StatsSheet created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        StatsSheet.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => stats_sheet.id, :stats_sheet => {'these' => 'params'}
      end

      it "assigns the requested stats_sheet as @stats_sheet" do
        stats_sheet = StatsSheet.create! valid_attributes
        put :update, :id => stats_sheet.id, :stats_sheet => valid_attributes
        assigns(:stats_sheet).should eq(stats_sheet)
      end

      it "redirects to the stats_sheet" do
        stats_sheet = StatsSheet.create! valid_attributes
        put :update, :id => stats_sheet.id, :stats_sheet => valid_attributes
        response.should redirect_to(stats_sheet)
      end
    end

    describe "with invalid params" do
      it "assigns the stats_sheet as @stats_sheet" do
        stats_sheet = StatsSheet.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        StatsSheet.any_instance.stub(:save).and_return(false)
        put :update, :id => stats_sheet.id.to_s, :stats_sheet => {}
        assigns(:stats_sheet).should eq(stats_sheet)
      end

      it "re-renders the 'edit' template" do
        stats_sheet = StatsSheet.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        StatsSheet.any_instance.stub(:save).and_return(false)
        put :update, :id => stats_sheet.id.to_s, :stats_sheet => {}
        response.should render_template("edit")
      end
    end
  end
end
