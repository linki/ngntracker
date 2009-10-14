class Ticket < ActiveRecord::Base
  attr_accessible :name, :description, :solution, :priority, :category_id, :organizer_id, :published
  
  validates_presence_of :name
  
  belongs_to :user
  belongs_to :category
  
  belongs_to :organizer
  belongs_to :portal
  
  has_many :comments, :dependent => :destroy
  has_many :pages, :dependent => :destroy
  
  has_many :visits, :dependent => :destroy
  
  publishable
    
  getter_for :user      => :username,
             :category  => :name,
             :organizer => :name,
             :portal    => :name
             
  named_scope :recent, :order => 'updated_at DESC'
end
