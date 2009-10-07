class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id
  
  validates_presence_of :name
  
  acts_as_nested_set
end
