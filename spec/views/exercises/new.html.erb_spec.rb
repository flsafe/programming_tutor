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
end
