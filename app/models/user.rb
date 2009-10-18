class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation
    
  validates_presence_of :username
  
  has_many :tickets
  has_many :comments
  
  has_many :pages
  
  has_many :assigned_tickets, :class_name => 'Ticket', :foreign_key => 'assignee_id'
  
  has_many :visits, :dependent => :destroy
  
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
end
