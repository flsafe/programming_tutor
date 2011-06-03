require 'spec_helper'

describe "StatsSheets" do
  describe "GET /stats_sheets" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get stats_sheets_path
      response.status.should be(200)
    end
  end
end
