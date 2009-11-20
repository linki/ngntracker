class Tweet < ActiveRecord::Base
  attr_accessible :text
  
  validates_presence_of :text, :user_id
  
  belongs_to :user
end
