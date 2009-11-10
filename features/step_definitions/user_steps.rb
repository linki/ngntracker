Given /^no users exist$/ do
  User.delete_all
end

Then /^I should have ([0-9]+) users? in the database$/ do |count|
  User.count.should == count.to_i
end

When(/^I fill in "([^\"]*)" with #{capture_model}'s (\w+)$/) do |field, owner, attribute|
  fill_in(field, :with => model(owner).send(attribute))
end