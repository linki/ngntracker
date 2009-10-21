class ActiveRecord::Base
  include GetterFor
  include Permalinked
  include Publishable
  include Archivable
  include Recyclable  
end