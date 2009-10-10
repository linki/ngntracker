class Comment < ActiveRecord::Base
  attr_accessible :text
  
  validates_presence_of :text, :ticket_id, :user_id
  
  belongs_to :ticket
  belongs_to :user
  
  getter_for :ticket => :name,
             :user => :username
end
