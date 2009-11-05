require File.dirname(__FILE__) + '/../spec_helper'

describe Ticket do
  it "should be valid" do
    Factory.build(:ticket).should be_valid
  end
  
  it "should require a name" do
    Factory.build(:ticket, :name => '').should_not be_valid
  end

  it "should require a description" do
    Factory.build(:ticket, :description => '').should_not be_valid
  end

  it "should require a category" do
    Factory.build(:ticket, :category => nil).should_not be_valid
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

  it "should assign pages" do
    pages = [Factory(:page)]
    Factory.build(:ticket, :pages => pages).pages.should == pages
  end  
  
  it "should assign watches" do
    watches = [Factory(:watch)]
    Factory.build(:ticket, :watches => watches).watches.should == watches
  end

  it "should assign watching users" do
    watching_users = [Factory(:user)]
    Factory.build(:ticket, :watching_users => watching_users).watching_users.should == watching_users
  end
  
  it "should assign visits" do
    visits = [Factory(:visit)]
    Factory.build(:ticket, :visits => visits).visits.should == visits
  end
  
  describe "close" do
    it "should close" do
      ticket = Factory(:ticket)
      ticket.should be_open
      ticket.close
      ticket.should be_closed
    end
  end
end
