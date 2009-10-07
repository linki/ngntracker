require File.dirname(__FILE__) + '/../spec_helper'

describe Category do
  it "should be valid" do
    Factory.build(:category).should be_valid
  end
  
  it "should require a name" do
    Factory.build(:category, :name => '').should_not be_valid
  end
end
