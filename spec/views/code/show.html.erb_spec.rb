require 'spec_helper'

describe "code/show.html.erb" do
  before(:each) do
    @exercise = assign(:exercise, stub_model(Exercise,
      :title => "Title",
      :description => "MyText",
      :text => "MyText",
      :prototype=>"int main()"))
    view.stub(:current_user).and_return(stub_model(User,
                                                  :seconds_left_in_code_session=>117))
  end

  it "renders the exercise prototype in the text editor" do
    render
    rendered.should have_selector("textarea#text_editor",
                                  :content=>@exercise.prototype)
  end

  it "renders the exercise problem text" do
    render
    rendered.should have_selector("div#exercise_problem_text", :content=>@exercise.text)
  end

  it "renders the time remainng" do
    render
    rendered.should have_selector("#timer", :content=>"01:57")
  end
end
