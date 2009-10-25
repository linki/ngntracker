class Ticket < ActiveRecord::Base
  attr_accessible :name, :description, :solution, :priority, :category_id, :organizer_id, :assignee_id, :published
  
  validates_presence_of :name, :description, :category
  
  belongs_to :user
  belongs_to :category
  
  belongs_to :organizer
  belongs_to :portal
  
  belongs_to :assignee, :class_name => 'User'
  
  has_many :comments, :dependent => :destroy
  has_many :pages, :dependent => :destroy
  
  has_many :visits, :dependent => :destroy
  
  has_many :watches, :dependent => :destroy
  has_many :watching_users, :through => :watches, :source => :user
  
  publishable
  
  archivable
  
  recyclable
    
  getter_for :user      => :name,
             :category  => [:name, :name_with_ancestors],
             :organizer => :name,
             :portal    => :name,
             :assignee  => :name
             
  named_scope :recent, :order => 'updated_at DESC'
  
  include AASM
  
  aasm_column :state
  
  aasm_initial_state :new

  aasm_state :new
  aasm_state :process
  aasm_state :closed
  
  aasm_event :process do
    transitions :to => :process, :from => [:new]
  end

  aasm_event :close do
    transitions :to => :closed, :from => [:new, :process]
  end
  
  def self.search(params)
    recent.deleted(params[:deleted] || false).archived(params[:archived] || false)
    # published
  end
end
