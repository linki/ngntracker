require File.dirname(__FILE__) + '/../spec_helper'

describe Portal do
  it "should be valid" do
    Factory.build(:portal).should be_valid
  end
  
  it "should require a name" do
    Factory.build(:portal, :name => '').should_not be_valid
  end
  
  it "should have an organizer" do
    organizer = Factory(:organizer)
    Factory.build(:portal, :organizer => organizer).organizer.should == organizer
  end  
end
