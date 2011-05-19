Given /^I am an admin user$/ do
  user = User.create(:username=>'Admin',
                     :password=>"password",
                     :password_confirmation=>'password',
                     :email=>'mail@mail.com')
  user.admin = true 
  user.save!

  visit new_user_session_path
  fill_in "Username", :with=>'Admin'
  fill_in "Password", :with=>'password'
  click_button "Login"
end

Given /^I am a user$/ do
  User.create(:username=>'Joe Blow',
              :password=>'password',
              :password_confirmation=>'password',
              :email=>'job@mail.com')

  visit login_path 
  fill_in "Username", :with=>'Joe Blow'
  fill_in "Password", :with=>'password'
  click_button "Login"
end
