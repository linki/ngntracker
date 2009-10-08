require File.dirname(__FILE__) + '/../spec_helper'

describe Organizer do
  it "should be valid" do
    Factory.build(:organizer).should be_valid
  end
  
  it "should require a name" do
    Factory.build(:organizer, :name => '').should_not be_valid
  end
end
