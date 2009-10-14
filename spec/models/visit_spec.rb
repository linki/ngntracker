require File.dirname(__FILE__) + '/../spec_helper'

describe Visit do
  it "should be valid" do
    Visit.new.should be_valid
  end
end
