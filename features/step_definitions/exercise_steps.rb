require 'vcr'

POINTS_PER_XP_FIELD = 100

Given /^there exists an exercise in the database$/ do
  @a_course = Factory.create :course
  @a_lesson = @a_course.lessons.first
  @an_exercise = @a_lesson.exercises.first
  StatsSheet.shared_xp_fields.each do |m|
    @an_exercise.stats_sheet.send(m.to_s+'=', POINTS_PER_XP_FIELD)
  end
  @an_exercise.save!
end

Given /^I am doing an exercise$/ do
   Given "there exists an exercise in the database"
   visit exercises_path
   click_button "Start Exercise" 
end

When /^I create a new exercise$/ do
  lesson = Lesson.create!(:title=>"a temp lesson")
  visit new_exercise_path
 if has_css?("#new_exercise")
    select lesson.title, :from=>"Lesson" 
    fill_in "Title", :with=>"Title"
    check   "Finished"
    fill_in "Description", :with=>"Description"
    fill_in "Sorting xp", :with=>'1'
    fill_in "Searching xp", :with=>'1'
    fill_in "Numeric xp", :with=>'1'
    fill_in "Linked list xp", :with=>'1'
    fill_in "Hash xp", :with=>'1'
    fill_in "Array xp", :with=>'1'
    attach_file "Upload Unit Test", "#{Rails.root}/content/unit_test.c"
    fill_in "Minutes", :with=>"60"
    fill_in "Text", :with=>"Text"
    fill_in "Tutorial", :with=>"Tutorial"
    fill_in "Hint Text", :with=>"Hint1"
    click_button "Create"
  end
end

When /^I am viewing the code page for the exercise$/ do
  visit lesson_path(@an_exercise.lesson)
  click_button("Start Exercise")
end

When /^I complete the exercise$/ do 
  gs = GradeSheet.new
  gs.user = @I
  gs.exercise = @an_exercise
  gs.lesson = @a_lesson
  gs.course = @a_course
  gs.src_code = "Src code"
  gs.add_unit_test( {"Test all letters removed"=>
                      {:input=>"c",
                      :output=>"c",
                      :expected=>"c",
                      :points=>100}})
  gs.save!
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
  fill_in "text-editor", :with=>src
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
  fill_in "text-editor", :with=>src
end

When /^I type a correct solution$/ do
  fill_in "text-editor", :with=>IO.read(File.join(Rails.root, "content", "solution.c"))
end

When /^I press the check syntax button$/ do
  click_button "Check Syntax" 
end

When /^I press the check solution button$/ do
  VCR.use_cassette('check-solution', :re_record_interval => 1.days) do
    click_button "Check Solution"
  end
end

When /^I press the submit solution button$/ do
  VCR.use_cassette('grade-solution', :re_record_interval => 1.days)  do
    click_button "Submit Solution"
  end
end

Then /^I should see the exercise prototype$/ do
  page.should have_css("textarea#text-editor")
end

Then /^I should see the exercise text$/ do
  page.should have_css("div#exercise-problem-text", :content=>@an_exercise.text)
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

Then /^I should see a grade sheet with a perfect grade$/ do
  page.should have_css("#grade-sheet td", :text => "20", :count => 5)
  page.should have_css("#grade-sheet", :text => "100")
end

Then /^I should see my src code$/ do
  page.should have_css("#grade-sheet", :text=>IO.read(File.join(Rails.root, "content", "solution.c")))
end

