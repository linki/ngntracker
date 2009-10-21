Given /^I am logged in$/ do
  User.delete_all
  Factory(:user, :username => 'martin', :password => 'secret')
  visit login_url
  fill_in "Username", :with => 'martin'
  fill_in "Password", :with => 'secret'
  click_button "Log in"
end