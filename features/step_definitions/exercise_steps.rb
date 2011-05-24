Given /^there exists an exercise in the database$/ do
  @an_exercise = Exercise.new do |e|
    e.title = "title"
    e.minutes = 15
    e.unit_test = UnitTest.new(:src_code=>IO.read("#{Rails.root}/content/unit_test.rb"),
                               :src_language=>"ruby")
    e.solution_template = SolutionTemplate.new(:src_code=>IO.read("#{Rails.root}/content/solution_template.c"),
                                               :src_language=>'c')
    e.lesson = Lesson.create!(:title=>"a lesson")
  end
  @an_exercise.save!
end

Given /^I am doing an exercise$/ do
   Given "there exists an exercise in the database"
   visit start_coding_path(@an_exercise, :id=>@an_exercise.id)
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

When /^I type a program with a syntax error$/ do
  src =<<-END
  int main(){
    int i
    int count = 1;
    for (i = 1 ; i <= 100 ; i++)
      ++count;
  }
  END
  fill_in "text_editor", :with=>src
end

When /^I type a program without a syntax error$/ do
  src =<<-END
  int main(){
    int i;
    int count = 1;
    for (i = 1 ; i <= 100 ; i++)
      ++count;
  }
  END
  fill_in "text_editor", :with=>src
end

When /^I type a correct solution$/ do
  fill_in "text_editor", :with=>"test"
end

When /^I press the check syntax button$/ do
  click_button "Check Syntax" 
end

When /^I press the check solution button$/ do
  click_button "Check Solution"
end

Then /^I should see the exercise prototype$/ do
  page.should have_css("textarea#text_editor")
end

Then /^I should see the exercise text$/ do
  page.should have_css("div#exercise_problem_text", :content=>@an_exercise.text)
end

Then /^I should see the time remaining for the exercise$/ do
  page.should have_css("#timer", :text=>@an_exercise.minutes.to_s)
end

Then /^I should see a syntax error message$/ do
  page.should have_css("#message", :text=>"syntax error")
end

Then /^I should not see a syntax error message$/ do
  page.should have_css("#message", :text=>"No syntax error detected!") 
end

Then /^I should see an 'ok' message$/ do
  page.should have_css("#message", :text=>"This looks like it could work!")
end
