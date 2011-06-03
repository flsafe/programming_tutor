require 'spec_helper'

describe "stats_sheets/index.html.erb" do
  before(:each) do
    assign(:stats_sheets, [
      stub_model(StatsSheet,
        :syntax_checks => 1,
        :solution_checks => 1,
        :total_practice_seconds => 1,
        :total_xp => 1,
        :sorting_xp => 1,
        :searching_xp => 1,
        :numeric_xp => 1,
        :hash_xp => 1,
        :linked_list_xp => 1,
        :array_xp => 1,
        :level => 1,
        :xp_to_next_level => 1
      ),
      stub_model(StatsSheet,
        :syntax_checks => 1,
        :solution_checks => 1,
        :total_practice_seconds => 1,
        :total_xp => 1,
        :sorting_xp => 1,
        :searching_xp => 1,
        :numeric_xp => 1,
        :hash_xp => 1,
        :linked_list_xp => 1,
        :array_xp => 1,
        :level => 1,
        :xp_to_next_level => 1
      )
    ])
  end

  it "renders a list of stats_sheets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 24
  end
end
