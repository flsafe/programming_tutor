require 'spec_helper'

describe "grade_sheets/index.html.erb" do
  before(:each) do
    assign(:grade_sheets, [
      stub_model(GradeSheet,
        :user_id => 1,
        :exercise_id => 1,
        :grade => 1.5,
        :tests => "MyText",
        :src_code => "MyText",
        :time_taken => 1
      ),
      stub_model(GradeSheet,
        :user_id => 1,
        :exercise_id => 1,
        :grade => 1.5,
        :tests => "MyText",
        :src_code => "MyText",
        :time_taken => 1
      )
    ])
  end

  it "renders a list of grade_sheets"
end
