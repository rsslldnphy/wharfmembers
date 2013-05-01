When /^I visit a page$/ do
  visit '/'
end

Then /^I am asked to log in$/ do
  page.should have_content 'Sign in'
  page.should have_field 'Email'
  page.should have_field 'Password'
end

Given /^I am on the sign up page$/ do
  visit '/'
  page.should have_content 'Sign in'
end

When /^I fill in my email and password$/ do
  fill_in 'Email', with: 'russell@russelldunphy.com'
  fill_in 'Password', with: 'test1234'
  click_button 'Sign in'
end

Then /^I am logged in$/ do
  page.should have_content 'Signed in successfully'
end

Given /^I have logged in$/ do
  steps %{
    * I am on the sign up page
    * I fill in my email and password
    * I am logged in
  }
end

When /^I choose to log out$/ do
  click_on 'log out'
end

Then /^I am taken back to the login page$/ do
  page.should have_content 'Sign in'
end
