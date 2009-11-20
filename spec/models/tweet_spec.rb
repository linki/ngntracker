require File.dirname(__FILE__) + '/../spec_helper'

describe Tweet do
  it "should be valid" do
    Factory.build(:tweet).should be_valid
  end
  
  it "should require a text" do
    Factory.build(:tweet, :text => '').should_not be_valid
  end  
  
  it "should require a user" do
    Factory.build(:tweet, :user => nil).should_not be_valid
  end  
end