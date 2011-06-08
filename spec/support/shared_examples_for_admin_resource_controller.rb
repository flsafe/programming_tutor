require 'spec_helper'

# Only allows show and view actions. Does't
# allow other action unless the current user
# is an admin user.

shared_examples_for "admin resource controller" do
  before(:each) do
    current_user = stub_model(User, :admin? => false) 
    controller.stub(:current_user).and_return(current_user)
  end

  it "renders the home page if new is requested" do
    get :new
    response.should redirect_to home_path 
  end
  
  it "renders the home page if create is posted" do
    post :create
    response.should redirect_to home_path 
  end
  
  it "renders the home page if edit is requested" do
    get :edit, :id => "should redirect" 
    response.should redirect_to home_path 
  end
  
  it "renders the home page if put" do
    put :update, :id => "should redirect" 
    response.should redirect_to home_path 
  end
  
  it "renders the home page if destroy" do
    delete  :destroy, :id=>"should redirect"
    response.should redirect_to home_path 
  end
end
