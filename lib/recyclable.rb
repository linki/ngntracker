module Recyclable
  TRUE_VALUES = ["true", true, "1", 1] unless const_defined?(:TRUE_VALUES)
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def recyclable(options = {})
      class_eval do
        def deleted?
          !!deleted_at && deleted_at <= Time.now
        end

        def destroy_or_trash!
          deleted? ? destroy : trash!
        end

        def trash!
          update_attribute(:deleted_at, Time.now.utc) unless deleted?
        end

        def recycle!
          update_attribute(:deleted_at, nil)
        end
      end
      
      named_scope :deleted, lambda { |*args|
        if args.first.nil? || TRUE_VALUES.include?(args.first)
          { :conditions => ['deleted_at IS NOT NULL AND deleted_at <= ?', Time.now.utc] }
        else
          { :conditions => ['deleted_at IS NULL OR deleted_at > ?', Time.now.utc] }
        end
      }
      
      def self.not_deleted
        deleted(false)
      end
    end
  end
end