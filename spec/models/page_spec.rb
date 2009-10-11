require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  it "should be valid" do
    Factory.build(:page).should be_valid
  end
  
  it "should require a name" do
    Factory.build(:page, :name => '').should_not be_valid
  end
  
  it "should require a permalink" do
    Factory.build(:page, :permalink => '').should_not be_valid
  end

  it "should assign a user" do
    user = Factory(:user)
    Factory.build(:page, :user => user).user.should == user
  end  

  it "should assign a ticket" do
    ticket = Factory(:ticket)
    Factory.build(:page, :ticket => ticket).ticket.should == ticket
  end  
end
