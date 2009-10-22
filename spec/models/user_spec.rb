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
  
  it "should assign pages" do
    pages = [Factory(:page)]
    Factory.build(:user, :pages => pages).pages.should == pages
  end  
  
  it "should assign watches" do
    watches = [Factory(:watch)]
    Factory.build(:user, :watches => watches).watches.should == watches
  end

  it "should assign watched tickets" do
    watched_tickets = [Factory(:ticket)]
    Factory.build(:user, :watched_tickets => watched_tickets).watched_tickets.should == watched_tickets
  end
  
  it "should assign visits" do
    visits = [Factory(:visit)]
    Factory.build(:user, :visits => visits).visits.should == visits
  end
  
  it "should assign visited tickets" do
    visited_tickets = [Factory(:ticket)]
    Factory.build(:user, :visited_tickets => visited_tickets).visited_tickets.should == visited_tickets
  end  
end
