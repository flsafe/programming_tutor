require 'spec_helper'

describe "lessons/show.html.erb" do
  before(:each) do
    @lesson = assign(:lesson, stub_model(Lesson,
      :title => "Title",
      :description => "MyText",
      :text => "MyText",
      :exercises=>[stub_model(Exercise, :id=>1, :title=>"ex1", :minutes=>1), 
                   stub_model(Exercise, :id=>2, :title=>"ex2", :minutes=>1)]))

    assign(:grades, {1=>100, 2=>50})
  end

  it "renders the exercises in the lesson" do
    render
    rendered.should have_selector("li.exercise_li", :count=>2)
  end

  it "renders the exercise grades" do
    render
    rendered.should have_selector("#lesson_exercises") do |exercises|
      exercises.should contain("100")
      exercises.should contain("50")
    end
  end

  it "renders the lesson text" do
    render
    rendered.should contain(@lesson.text)
  end
end
