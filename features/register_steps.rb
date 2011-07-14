When /^I submit correct registration info on the registration page$/ do
  visit register_path 
  within("form#new_user") do
    fill_in "Username", :with => "user1"
    fill_in "Email", :with => "user1@mail.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
  click_button "Sign Up"
  end
end

Then /^I should be registered$/ do
  User.where(:username => "user1").count.should == 1 
end

Then /^I should be automatically logged in$/ do
  UserSession.find.record.should_not == nil
  page.should have_content("You are registered! Welcome to PrepCode!")
  page.should have_content("user1")
end

