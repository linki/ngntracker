require File.dirname(__FILE__) + '/../spec_helper'

describe Organizer do
  it "should be valid" do
    Factory.build(:organizer).should be_valid
  end
  
  it "should require a name" do
    Factory.build(:organizer, :name => '').should_not be_valid
  end
  
  it "should assign portals" do
    portals = [Factory(:portal)]
    Factory.build(:organizer, :portals => portals).portals.should == portals
  end
  
  it "should assign tickets" do
    tickets = [Factory(:ticket)]
    Factory.build(:organizer, :tickets => tickets).tickets.should == tickets
  end    
end
