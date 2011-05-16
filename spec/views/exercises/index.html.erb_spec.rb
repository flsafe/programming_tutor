require 'spec_helper'

describe "exercises/index.html.erb" do
  before(:each) do
    assign(:exercises, [
      stub_model(Exercise,
        :title => "title",
        :description => "description",
        :text => "text",
        :tutorial => "tutorial",
        :minutes => 1,
        :unit_test=>stub_model(UnitTest),
        :solution_template=>stub_model(SolutionTemplate),
        :hints=>[stub_model(Hint)]
      ),
      stub_model(Exercise,
        :title => "title",
        :description => "description",
        :text => "text",
        :tutorial => "tutorial",
        :minutes => 1,
        :unit_test=>stub_model(UnitTest),
        :solution_template=>stub_model(SolutionTemplate),
        :hints=>[stub_model(Hint)]
      )
    ])
  end

  it "renders a list of exercises" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "text".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "tutorial".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
