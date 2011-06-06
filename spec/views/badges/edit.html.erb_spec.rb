require 'spec_helper'

describe "badges/edit.html.erb" do
  before(:each) do
    @badge = assign(:badge, stub_model(Badge,
      :title => "MyString",
      :description => "MyString",
      :earn_conditions => "MyString"
    ))
  end

  it "renders the edit badge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => badges_path(@badge), :method => "post" do
      assert_select "input#badge_title", :name => "badge[title]"
      assert_select "input#badge_description", :name => "badge[description]"
      assert_select "input#badge_earn_conditions", :name => "badge[earn_conditions]"
    end
  end
end
