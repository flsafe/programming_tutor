Given /^I create a new lesson$/ do
  visit new_lesson_path

  if has_css?("form.new_lesson")
    fill_in "Title", :with=>'title'
    fill_in "Description", :with=>'description'
    fill_in "Text", :with=>'text'
    click_button "Create Lesson"
  end
end
