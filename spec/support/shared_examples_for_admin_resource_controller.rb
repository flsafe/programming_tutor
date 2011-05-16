require 'spec_helper'

shared_examples_for "admin resource controller" do
  before(:each) do
    current_user = stub_model(User, :admin? => false) 
    controller.stub(:current_user).and_return(current_user)
  end

  it "renders the login page if new is requested" do
    get :new
    response.should redirect_to home_path 
  end
  
  it "renders the login page if create is posted" do
    post :create
    response.should redirect_to home_path 
  end
  
  it "renders the login page if edit is requested" do
    get :edit, :id => "should redirect" 
    response.should redirect_to home_path 
  end
  
  it "renders the login page if put" do
    put :update, :id => "should redirect" 
    response.should redirect_to home_path 
  end
  
  it "renders the login page if destroy" do
    delete  :destroy, :id=>"should redirect"
    response.should redirect_to home_path 
  end
end
