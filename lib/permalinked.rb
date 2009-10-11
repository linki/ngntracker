module Permalinked
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def permalinked(options = {})
      options[:by]       ||= :name
      options[:id]         =  true unless options[:id]       == false
      options[:downcase]   =  true unless options[:downcase] == false
   
      instance_eval do
        define_method "to_param" do
          permalink  = options[:id] == true ? send(:id).to_s + '-' : ''
          permalink += send(options[:by].to_sym).gsub(/\s/, '-').gsub(/[^\w-]/, '').gsub(/--/, '-') if send(options[:by].to_sym)
          permalink.downcase! if options[:downcase] == true
          permalink.to_s
        end
      end
    end
  end
end