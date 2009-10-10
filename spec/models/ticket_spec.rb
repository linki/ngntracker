require File.dirname(__FILE__) + '/../spec_helper'

describe Ticket do
  it "should be valid" do
    Factory.build(:ticket).should be_valid
  end
  
  it "should require a name" do
    Factory.build(:ticket, :name => '').should_not be_valid
  end
  
  it "should assign a user" do
    user = Factory(:user)
    Factory.build(:ticket, :user => user).user.should == user
  end  

  it "should assign a category" do
    category = Factory(:category)
    Factory.build(:ticket, :category => category).category.should == category
  end  

  it "should assign an organizer" do
    organizer = Factory(:organizer)
    Factory.build(:ticket, :organizer => organizer).organizer.should == organizer
  end  
  
  it "should assign a portal" do
    portal = Factory(:portal)
    Factory.build(:ticket, :portal => portal).portal.should == portal
  end
  
  it "should assign comments" do
    comments = [Factory(:comment)]
    Factory.build(:ticket, :comments => comments).comments.should == comments
  end  
end
