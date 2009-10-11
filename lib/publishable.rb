module Publishable
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def publishable(options = {})
      instance_eval do
        define_method "published?" do
          send(:published)
        end

        define_method "published" do
          true == (send(:published_at) && send(:published_at).utc <= Time.now.utc)
        end

        define_method "published=" do |boolean|
          if boolean == "1" || boolean == true
            write_attribute(:published_at, Time.now.utc) unless send(:published?)
          else
            write_attribute(:published_at, nil) if send(:published?)
          end
        end
        
        define_method "publish!" do |*args|
          send(:update_attribute, :published_at, (args.first || Time.now).utc) unless send(:published?)
        end

        define_method "unpublish!" do
          send(:update_attribute, :published_at, nil) if send(:published?)
        end

        named_scope :published, lambda { |*args|
          { :conditions => ['published_at IS NOT NULL AND published_at <= ?', (args.first || Time.now).utc] }
        } 
      end
    end
  end
end