module Recyclable
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def recyclable(options = {})
      instance_eval do        
        define_method "deleted?" do
          !!send(:deleted_at) && send(:deleted_at) <= Time.now
        end

        define_method "destroy_or_trash!" do
          send(:deleted?) ? send(:destroy) : send(:trash!)
        end

        define_method "trash!" do
          send(:update_attribute, :deleted_at, Time.now.utc) unless send(:deleted?)
        end

        define_method "recycle!" do
          send(:update_attribute, :deleted_at, nil) if send(:deleted?)
        end

        named_scope :deleted, lambda { |*args|
          if args.first.nil? || ["true", true, "1", 1].include?(args.first)
            { :conditions => ['deleted_at IS NOT NULL AND deleted_at <= ?', Time.now.utc] }
          else
            { :conditions => ['deleted_at IS NULL OR deleted_at > ?', Time.now.utc] }
          end
        }
      end
    end
  end
end