class Comment < ActiveRecord::Base
  attr_accessible :text
  
  validates_presence_of :text, :ticket_id, :user_id
  
  belongs_to :ticket, :touch => true
  belongs_to :user
  
  getter_for :ticket => :name,
             :user => :username
             
  named_scope :recent, :order => 'created_at DESC'
end
