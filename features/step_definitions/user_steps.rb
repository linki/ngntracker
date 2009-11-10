Given /^no users exist$/ do
  User.delete_all
end

Then /^I should have ([0-9]+) users? in the database$/ do |count|
  User.count.should == count.to_i
end