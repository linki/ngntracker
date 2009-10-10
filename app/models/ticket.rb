class Ticket < ActiveRecord::Base
  attr_accessible :name, :description, :solution, :state, :priority, :direct_link, :mantis_id, :category_id, :organizer_id, :portal_id, :deadline_at, :published_at, :closed_at, :archived_at, :deleted_at
  
  validates_presence_of :name
  
  belongs_to :user
  belongs_to :category
  
  belongs_to :organizer
  belongs_to :portal
  
  has_many :comments, :dependent => :destroy
  
  getter_for :user => :username,
             :category => :name,
             :organizer => :name,
             :portal => :name
end
