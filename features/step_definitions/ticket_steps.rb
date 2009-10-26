Given /^I have the following tickets in the database:$/ do |table|
  Ticket.delete_all
  table.hashes.each do |hash|
    user_login = hash['user_login']
    raise Exception if user_login.blank?
    user = User.find_by_login(user_login) || Factory(:user, :login => user_login)
    Factory(:ticket, hash.except('user_login').merge(:user => user))
  end
end

Given /^I have no tickets in the database$/ do
  Ticket.delete_all
end

Then /^I should have no tickets in the database$/ do
  Ticket.count.should be_zero
end

Then /^I should have ([0-9]+) tickets? in the database$/ do |count|
  Ticket.count.should == count.to_i
end

