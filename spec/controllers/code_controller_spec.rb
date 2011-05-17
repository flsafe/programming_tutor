require 'spec_helper'

describe CodeController do

  def valid_attributes
    {:title=>"Title1",
    :description=>"Description1",
    :text=>"Text1"}
  end

  describe "#start" do
    it "redirects to #code" do
      exercise = stub_model(Exercise)
      get 'start', :id=>1
      response.should redirect_to(:action=>:show)
    end
  end
end
