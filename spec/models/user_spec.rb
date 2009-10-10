require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  it "should be valid" do
    Factory.build(:user).should be_valid
  end
  
  it "should require a username" do
    Factory.build(:user, :username => '').should_not be_valid
  end
  
  it "should assign tickets" do
    tickets = [Factory(:ticket)]
    Factory.build(:user, :tickets => tickets).tickets.should == tickets
  end
  
  it "should assign comments" do
    comments = [Factory(:comment)]
    Factory.build(:user, :comments => comments).comments.should == comments
  end
end
