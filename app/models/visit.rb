class Visit < ActiveRecord::Base
  attr_accessible :ticket
  
  validates_presence_of :user_id, :ticket_id
  
  belongs_to :user
  belongs_to :ticket
  
  named_scope :of,  lambda { |user|   { :conditions => { :user_id   => user   } }}
  named_scope :for, lambda { |ticket| { :conditions => { :ticket_id => ticket } }}
end
