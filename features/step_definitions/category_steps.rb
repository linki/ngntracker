Given /^I have no categories in the database$/ do
  Category.delete_all
end

Given /^I have the category "([^\"]*)"$/ do |name|
  Factory(:category, :name => name)
end

Then /^I should have ([0-9]+) categor(y|ies) in the database$/ do |count, ignore|
  Category.count.should == count.to_i
end