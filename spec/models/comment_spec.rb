require File.dirname(__FILE__) + '/../spec_helper'

describe Comment do
  it "should be valid" do
    Factory.build(:comment).should be_valid
  end
  
  it "should require a text" do
    Factory.build(:comment, :text => '').should_not be_valid
  end

  it "should require a ticket" do
    Factory.build(:comment, :ticket => nil).should_not be_valid
  end

  it "should require a user" do
    Factory.build(:comment, :user => nil).should_not be_valid
  end

  it "should assign a ticket" do
    ticket = Factory(:ticket)
    Factory.build(:comment, :ticket => ticket).ticket.should == ticket
  end
  
  it "should assign a user" do
    user = Factory(:user)
    Factory.build(:comment, :user => user).user.should == user
  end
end
