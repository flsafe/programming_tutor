Given /^there exists a user in the database$/ do
  @I = User.create(:username=>'Joe Blow',
              :password=>'password',
              :password_confirmation=>'password',
              :email=>'job@mail.com')
  @I.save!
end

Given /^I am not logged in$/ do
  visit logout_path
end

When /^I go to the login page$/ do
  visit login_path
end

When /enter a correct username and password$/ do
  within("#login-form-wrapper") do
    fill_in "Username", :with=>'Joe Blow'
    fill_in "Password", :with=>'password'
    click_button "Login"
  end
end

When /^enter an incorrect username and password$/ do
  within("#login-form-wrapper") do
    fill_in "Username", :with=>'John Doe'
    fill_in "Password", :with=>'letmein'
    click_button "Login"
  end
end

When /^I go to the account page$/ do
  visit account_path
end

When /^I click log out$/ do
  click_link "Logout"
end

Then /^I should see a generic error message$/ do
  page.should have_content 'Your login information is invalid'
end

Then /^I should see a login notification$/ do
  page.should have_content 'Logged in as'
end

Then /^I should see a logout notification$/ do
  page.should have_content 'Logout successful'
end
