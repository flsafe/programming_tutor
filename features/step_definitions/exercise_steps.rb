When /^I create a new exercise$/ do
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
    click_button "Create"
  end
end
