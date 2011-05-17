Given /^there exists an exercise in the database$/ do
  @an_exercise = Exercise.new do |e|
    e.title = "title"
    e.minutes = 1
    e.unit_test = UnitTest.new(:src_code=>IO.read("#{Rails.root}/content/unit_test.rb"),
                               :src_language=>"ruby")
    e.solution_template = SolutionTemplate.new(:src_code=>IO.read("#{Rails.root}/content/solution_template.c"),
                                               :src_language=>'c')
    e.lesson = Lesson.create!(:title=>"a lesson")
  end
  @an_exercise.save!
end

When /^I create a new exercise$/ do
  lesson = Lesson.create!(:title=>"a temp lesson")
  visit new_exercise_path
  if has_css?("#new_exercise")
    fill_in "Title", :with=>"Title"
    fill_in "Description", :with=>"Description"
    fill_in "Minutes", :with=>"60"
    fill_in "Text", :with=>"Text"
    fill_in "Tutorial", :with=>"Tutorial"
    fill_in "Hint Text", :with=>"Hint1"
    attach_file "Upload Unit Test", "#{Rails.root}/content/unit_test.rb"
    attach_file "Upload Solution Template", "#{Rails.root}/content/solution_template.c"
    select lesson.title, :from=>"Lesson" 
    click_button "Create"
  end
end

When /^I am viewing the code page for the exercise$/ do
  visit lesson_path(@an_exercise.lesson)
  click_link(@an_exercise.title)
end

Then /^I should see the exercise prototype$/ do
  page.should have_css("textarea#text_editor")
end

Then /^I should see the exercise text$/ do
  page.should have_css("div#exercise_problem_text", :content=>@an_exercise.text)
end


