require 'spec_helper'

describe "stats_sheets/edit.html.erb" do
  before(:each) do
    @stats_sheet = assign(:stats_sheet, stub_model(StatsSheet,
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
    ))
  end

  it "renders the edit stats_sheet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stats_sheets_path(@stats_sheet), :method => "post" do
      assert_select "input#stats_sheet_syntax_checks", :name => "stats_sheet[syntax_checks]"
      assert_select "input#stats_sheet_solution_checks", :name => "stats_sheet[solution_checks]"
      assert_select "input#stats_sheet_total_practice_seconds", :name => "stats_sheet[total_practice_seconds]"
      assert_select "input#stats_sheet_total_xp", :name => "stats_sheet[total_xp]"
      assert_select "input#stats_sheet_sorting_xp", :name => "stats_sheet[sorting_xp]"
      assert_select "input#stats_sheet_searching_xp", :name => "stats_sheet[searching_xp]"
      assert_select "input#stats_sheet_numeric_xp", :name => "stats_sheet[numeric_xp]"
      assert_select "input#stats_sheet_hash_xp", :name => "stats_sheet[hash_xp]"
      assert_select "input#stats_sheet_linked_list_xp", :name => "stats_sheet[linked_list_xp]"
      assert_select "input#stats_sheet_array_xp", :name => "stats_sheet[array_xp]"
      assert_select "input#stats_sheet_level", :name => "stats_sheet[level]"
      assert_select "input#stats_sheet_xp_to_next_level", :name => "stats_sheet[xp_to_next_level]"
    end
  end
end
