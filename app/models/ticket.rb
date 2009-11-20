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
  
  acts_as_audited
  
  publishable
  
  archivable
  
  recyclable
    
  getter_for :user      =>  :name,
             :category  => [:name, :name_with_ancestors],
             :organizer =>  :name,
             :portal    =>  :name,
             :assignee  =>  :name

  named_scope :recent, :order => 'tickets.updated_at DESC'

  named_scope :visible_for, lambda { |user|
    { :conditions => ['tickets.user_id = ? OR tickets.published_at IS NOT NULL AND tickets.published_at <= ?', user.id, Time.now.utc] }
  }
  
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
  
  def open?
    !closed?
  end
  
  def closed?
    state.to_sym == :closed
  end
  
  def assigned?(user = nil)
    user ? assignee == user : !!assignee
  end

  def self.active
    not_deleted.not_archived
  end

  named_scope :category_with_ancestors_id, lambda { |category_id|
    { :conditions => ['category_id IN (?)', Category.find(category_id).self_and_descendants] }
  }
  
  after_create :tweet_create_notification
  
  def tweet_create_notification
    user.tweet! "#{user.name} created Ticket #{name}."
  end
end
