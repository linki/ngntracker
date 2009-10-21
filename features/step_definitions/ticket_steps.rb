Given /^I have no tickets in the database$/ do
  Ticket.delete_all
end

Then /^I should have no tickets in the database$/ do
  Ticket.count.should be_zero
end

Then /^I should have ([0-9]+) tickets? in the database$/ do |count|
  Ticket.count.should == count.to_i
end