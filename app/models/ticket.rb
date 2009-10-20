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
    
  getter_for :user      => :username,
             :category  => [:name, :name_with_ancestors],
             :organizer => :name,
             :portal    => :name,
             :assignee  => :username
             
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

  named_scope :archived, lambda { |*args|
    if args.first.nil? || ["true", true, "1", 1].include?(args.first)
      { :conditions => ['archived_at IS NOT NULL AND archived_at <= ?', Time.now.utc] }
    else
      { :conditions => ['archived_at IS NULL OR archived_at > ?', Time.now.utc] }
    end
  }

  def archive
    self.update_attribute(:archived_at, Time.now)
  end
  
  named_scope :deleted, lambda { |*args|
    if args.first.nil? || ["true", true, "1", 1].include?(args.first)
      { :conditions => ['deleted_at IS NOT NULL AND deleted_at <= ?', Time.now.utc] }
    else
      { :conditions => ['deleted_at IS NULL OR deleted_at > ?', Time.now.utc] }
    end
  }
  
  def destroy_or_trash
    deleted? ? destroy : trash
  end
  
  def trash
    self.update_attribute(:deleted_at, Time.now)
  end
  
  def deleted?
    deleted_at && deleted_at <= Time.now
  end
end
