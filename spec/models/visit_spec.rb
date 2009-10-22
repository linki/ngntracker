require File.dirname(__FILE__) + '/../spec_helper'

describe Visit do
  it "should be valid" do
    Factory.build(:visit).should be_valid
  end
  
  it "should require a user" do
    Factory.build(:visit, :user => nil).should_not be_valid
  end

  it "should require a ticket" do
    Factory.build(:visit, :ticket => nil).should_not be_valid
  end
  
  it "should assign a user" do
    user = Factory(:user)
    Factory.build(:visit, :user => user).user.should == user
  end
  
  it "should assign a ticket" do
    ticket = Factory(:ticket)
    Factory.build(:visit, :ticket => ticket).ticket.should == ticket
  end  
end
