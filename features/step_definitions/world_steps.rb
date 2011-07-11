Then /^I should see a success message$/ do
  page.should have_content('success')  
end

Then /^I should see a failure message$/ do
  page.should have_content('failed')
end

Then /^I should be redirected to the login page$/ do
  page.should have_css("form.new_user_session")
end

Then /^I should be redirected to the home page$/ do
  page.should have_css("ul#newest_lessons")
end

Then /^I should be redirected to the account page$/ do
  current_url =~ /account$/
end