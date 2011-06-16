require 'spec_helper'

describe BadgesController do

  context "The user is not an admin" do

    it_should_behave_like "admin resource controller"

    before(:each) do
      controller.stub(:user).and_return(stub_model(User, :admin? => false))
    end

    describe "GET index" do
      it "only shows finished badges" do
        b = Factory.create :badge, :finished => false
        get :index
        assigns(:badges).count.should == 0
      end
    end

    describe "GET show" do
      it "redirects when unfinished badges are requested" do
        b = Factory.create :badge, :finished => false
        get :show, :id => b.id.to_s
        response.should redirect_to(home_path)
      end
    end
  end
end
