require "spec_helper"

describe StatsSheetsController do
  describe "routing" do

    it "routes to #index" do
      get("/stats_sheets").should route_to("stats_sheets#index")
    end

    it "routes to #new" do
      get("/stats_sheets/new").should route_to("stats_sheets#new")
    end

    it "routes to #show" do
      get("/stats_sheets/1").should route_to("stats_sheets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/stats_sheets/1/edit").should route_to("stats_sheets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/stats_sheets").should route_to("stats_sheets#create")
    end

    it "routes to #update" do
      put("/stats_sheets/1").should route_to("stats_sheets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/stats_sheets/1").should route_to("stats_sheets#destroy", :id => "1")
    end

  end
end
