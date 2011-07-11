Given /^I am an admin user$/ do
  @I = User.create(:username=>'Admin',
                   :password=>"password",
                   :password_confirmation=>'password',
                   :email=>'mail@mail.com')
  @I.admin = true 
  @I.save!

  visit new_user_session_path
  within("#login-form-wrapper") do
    fill_in "Username", :with=>'Admin'
    fill_in "Password", :with=>'password'
    click_button "Login"
  end
end

Given /^I am a user$/ do
  @I = User.create(:username=>'Joe Blow',
              :password=>'password',
              :password_confirmation=>'password',
              :email=>'job@mail.com')

  visit login_path 
  within("#login-form-wrapper") do
    fill_in "Username", :with=>'Joe Blow'
    fill_in "Password", :with=>'password'
    click_button "Login"
  end
end
