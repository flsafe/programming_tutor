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
    assign(:code, Code.new(:src_code=>@exercise.prototype))
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

  it "renders a message div" do
    render
    rendered.should have_selector("#message")
  end

  it "renders a 'Check Syntax' button" do
    render
    rendered.should have_selector("input[value='Check Syntax']")
  end

  it "renders a 'Check Solution' button" do
    render
    rendered.should have_selector("input[value='Check Solution']")
  end
end
