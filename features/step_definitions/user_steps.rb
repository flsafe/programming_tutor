Given /^I am an admin user$/ do
  user = User.new(:username=>'user1',
              :email=>'email')
  user.admin = true
  user.save
end
