Given /^I have the category "([^\"]*)"$/ do |name|
  Category.delete_all
  Factory(:category, :name => name)
end