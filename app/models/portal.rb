class Portal < ActiveRecord::Base
  attr_accessible :name, :uri, :organizer_id
  
  validates_presence_of :name
  
  belongs_to :organizer
  
  has_many :tickets
  
  getter_for :organizer => :name
end
