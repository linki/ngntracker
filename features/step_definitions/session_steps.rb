Given /^#{capture_model} is logged in$/ do |model_name|
  visit login_url
  fill_in "Login", :with => model(model_name).login
  fill_in "Password", :with => "secret"
  click_button "Log in"
end
  
Given /^I am logged in as "([^\"]*)" with the password "([^\"]*)"$/ do |login, password|
  visit login_url
  fill_in "Login", :with => login
  fill_in "Password", :with => password
  click_button "Log in"
end

Given /^I am logged in as "([^\"]*)"$/ do |login|
  Factory(:user, :login => login, :password => 'secret')
  Given 'I am logged in as "martin" with the password "secret"'
end

Given /^I am logged in$/ do
  Given 'I am logged in as "martin"'
end

Given /^I am logged in as an admin$/ do
  user = Factory(:user, :login => 'martin', :password => 'secret')
  # user.has_role!(:admin)
  Given 'I am logged in as "martin" with the password "secret"'
end