class Organizer < ActiveRecord::Base
  attr_accessible :name
  
  validates_presence_of :name
  
  has_many :portals  
  has_many :tickets
end