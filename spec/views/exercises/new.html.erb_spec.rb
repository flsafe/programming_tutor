require 'spec_helper'

describe "exercises/new.html.erb" do
  before(:each) do
    assign(:exercise, stub_model(Exercise,
      :title => "",
      :description => "",
      :text => "",
      :tutorial => "",
      :minutes => 1,
      :unit_test=>stub_model(UnitTest),
      :solution_template=>stub_model(SolutionTemplate),
      :hints=>[stub_model(Hint)]
    ).as_new_record)
  end

  it "renders new exercise form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => exercises_path, :method => "post" do
      assert_select "input#exercise_title", :name => "exercise[title]"
      assert_select "textarea#exercise_description", :name => "exercise[description]"
      assert_select "textarea#exercise_text", :name => "exercise[text]"
      assert_select "textarea#exercise_tutorial", :name => "exercise[tutorial]"
      assert_select "input#exercise_minutes", :name => "exercise[minutes]"
    end
  end
end
