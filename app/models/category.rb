class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id
  
  validates_presence_of :name
  
  acts_as_nested_set
  
  has_many :tickets
  
  def name_with_ancestors
    self_and_ancestors.collect(&:name).join(' >> ')
  end
end