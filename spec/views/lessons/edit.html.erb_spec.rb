require 'spec_helper'

describe "lessons/edit.html.erb" do
  before(:each) do
    @lesson = assign(:lesson, stub_model(Lesson,
      :title => "MyString",
      :description => "MyText",
      :text => "MyText"
    ))
  end

  it "renders the edit lesson form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => lessons_path(@lesson), :method => "post" do
      assert_select "input#lesson_title", :name => "lesson[title]"
      assert_select "textarea#lesson_description", :name => "lesson[description]"
      assert_select "textarea#lesson_text", :name => "lesson[text]"
    end
  end
end
