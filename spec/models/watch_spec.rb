require File.dirname(__FILE__) + '/../spec_helper'

describe Watch do
  it "should be valid" do
    Factory.build(:watch).should be_valid
  end
  
  it "should require a user" do
    Factory.build(:watch, :user => nil).should_not be_valid
  end

  it "should require a ticket" do
    Factory.build(:watch, :ticket => nil).should_not be_valid
  end
  
  it "should assign a user" do
    user = Factory(:user)
    Factory.build(:watch, :user => user).user.should == user
  end
  
  it "should assign a ticket" do
    ticket = Factory(:ticket)
    Factory.build(:watch, :ticket => ticket).ticket.should == ticket
  end  
end
