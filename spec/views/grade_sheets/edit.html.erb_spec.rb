require 'spec_helper'

describe "grade_sheets/edit.html.erb" do
  before(:each) do
    @grade_sheet = assign(:grade_sheet, stub_model(GradeSheet,
      :user_id => 1,
      :exercise_id => 1,
      :grade => 1.5,
      :tests => "MyText",
      :src_code => "MyText",
      :time_taken => 1
    ))
  end

  it "renders the edit grade_sheet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => grade_sheets_path(@grade_sheet), :method => "post" do
      assert_select "input#grade_sheet_user_id", :name => "grade_sheet[user_id]"
      assert_select "input#grade_sheet_exercise_id", :name => "grade_sheet[exercise_id]"
      assert_select "input#grade_sheet_grade", :name => "grade_sheet[grade]"
      assert_select "textarea#grade_sheet_tests", :name => "grade_sheet[tests]"
      assert_select "textarea#grade_sheet_src_code", :name => "grade_sheet[src_code]"
      assert_select "input#grade_sheet_time_taken", :name => "grade_sheet[time_taken]"
    end
  end
end
