class User < ActiveRecord::Base
  ROLES = %w(admin)
  
  attr_accessible :name, :login, :email, :password, :password_confirmation, :role
    
  validates_presence_of :name, :login, :email, :password, :password_confirmation
  
  has_many :tickets
  has_many :comments
  
  has_many :pages
  
  has_many :assigned_tickets, :class_name => 'Ticket', :foreign_key => 'assignee_id'
  
  has_many :visits, :dependent => :destroy
  has_many :visited_tickets, :through => :visits, :source => :ticket
    
  has_many :watches, :dependent => :destroy
  has_many :watched_tickets, :through => :watches, :source => :ticket
  
  has_many :tweets
  
  acts_as_authentic  
  
  def new_ticket?(ticket)
    return true unless visit_of(ticket)
    visit_of(ticket).updated_at.to_i < ticket.updated_at.to_i
  end
  
  def visit_of(ticket)
    visits.find_by_ticket_id(ticket.id)
  end
  
  def visit!(ticket)
    visits.find_or_initialize_by_ticket_id(ticket.id).increment!(:count)
  end

  def watch_of(ticket)
    watches.find_by_ticket_id(ticket.id)
  end

  def watching?(ticket)
    watch_of(ticket)
  end

  def watch!(ticket)
    watches.find_or_create_by_ticket_id(ticket.id)
  end
  
  def tweet!(text)
    tweets.create!(:text => text)
  end
  
  def admin?
    role && role.to_sym == :admin
  end
end
