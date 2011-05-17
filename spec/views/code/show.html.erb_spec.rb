require 'spec_helper'

describe "code/show.html.erb" do
  before(:each) do
    @exercise = assign(:exercise, stub_model(Exercise,
      :title => "Title",
      :description => "MyText",
      :text => "MyText",
      :prototype=>"int main()"))
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
end
