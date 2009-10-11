class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation
    
  acts_as_authentic
  
  validates_presence_of :username
  
  has_many :tickets
  has_many :comments
  
  has_many :pages
end
