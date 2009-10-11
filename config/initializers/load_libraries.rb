class ActiveRecord::Base
  include GetterFor
  include Permalinked
  include Publishable  
end