Given /^I create a new lesson$/ do
  visit new_lesson_path

  if has_css?("form.new_lesson")
    fill_in "Title", :with=>'title'
    fill_in "Image url", :with=>'http://lorempixum.com/260/170/sports/9'
    check "Finished"
    fill_in "Description", :with=>'description'
    fill_in "Text", :with=>'text'
    click_button "Create Lesson"
  end
end

Given /^there exists a lesson in the database$/ do
  exercises = []
  2.times do |i|
    exercises << Exercise.new(:title=>"tile#{i}", 
                              :minutes=>1,
                              :unit_test=>UnitTest.new(:src_code=>'c', :src_language=>'c'))
  end
  @a_lesson = Factory.build :lesson
  @a_lesson.exercises << exercises
  @a_lesson.save!
end

When /^I select a lesson to complete$/ do
  visit lessons_path
  click_link @a_lesson.title
end

Then /^I should see the lesson text$/ do
  page.should have_content(@a_lesson.text)
end

Then /^I should see the associated exercises$/ do
  @a_lesson.exercises.count.should_not == 0
  @a_lesson.exercises.each do |e|
    page.should have_css(".exercise-li-title", :text=>e.title)
  end
end
