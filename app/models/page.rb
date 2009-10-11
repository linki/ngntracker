class Page < ActiveRecord::Base
  attr_accessible :name, :content, :published
  
  validates_presence_of :name
  
  belongs_to :ticket
  belongs_to :user
  
  permalinked
  
  publishable
  
  getter_for :ticket => :name,
             :user => :username
end
