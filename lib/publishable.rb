module Publishable
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def publishable(options = {})
      instance_eval do
        define_method "published?" do
          !!send(:published)
        end

        define_method "published" do
          send(:published_at) && send(:published_at) <= Time.now
        end

        define_method "published=" do |published|
          if ["true", true, "1", 1].include?(published)
            write_attribute(:published_at, Time.now.utc) unless send(:published?)
          else
            write_attribute(:published_at, nil) if send(:published?)
          end
        end
        
        define_method "publish!" do
          send(:update_attribute, :published_at, Time.now.utc) unless send(:published?)
        end

        define_method "unpublish!" do
          send(:update_attribute, :published_at, nil) if send(:published?)
        end

        named_scope :published, lambda { |*args|
          if args.first.nil? || ["true", true, "1", 1].include?(args.first)
            { :conditions => ['published_at IS NOT NULL AND published_at <= ?', Time.now.utc] }
          else
            { :conditions => ['published_at IS NULL OR published_at > ?', Time.now.utc] }
          end
        }
      end
    end
  end
end