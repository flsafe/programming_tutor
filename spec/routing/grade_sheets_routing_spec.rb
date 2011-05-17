require "spec_helper"

describe GradeSheetsController do
  describe "routing" do

    it "routes to #index" do
      get("/grade_sheets").should route_to("grade_sheets#index")
    end

    it "routes to #new" do
      get("/grade_sheets/new").should route_to("grade_sheets#new")
    end

    it "routes to #show" do
      get("/grade_sheets/1").should route_to("grade_sheets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/grade_sheets/1/edit").should route_to("grade_sheets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/grade_sheets").should route_to("grade_sheets#create")
    end

    it "routes to #update" do
      put("/grade_sheets/1").should route_to("grade_sheets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/grade_sheets/1").should route_to("grade_sheets#destroy", :id => "1")
    end

  end
end
