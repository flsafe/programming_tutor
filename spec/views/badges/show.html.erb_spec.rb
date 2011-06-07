require 'spec_helper'

describe "badges/show.html.erb" do
  before(:each) do
    @badge = assign(:badge, stub_model(Badge,
      :title => "Title",
      :description => "Description",
      :earn_conditions => "Earn Conditions"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Earn Conditions/)
  end
end