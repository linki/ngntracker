module Publishable
  TRUE_VALUES = ["true", true, "1", 1] unless const_defined?(:TRUE_VALUES)
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def publishable(options = {})
      class_eval do
        def published?
          !!published
        end

        def published
          published_at && published_at <= Time.now
        end

        def published=(boolean)
          TRUE_VALUES.include?(boolean) ? publish : unpublish
        end
        
        def publish
          self.published_at = Time.now.utc unless published?
        end
        
        def unpublish
          self.published_at = nil
        end
      
        def publish!
          unless published?
            publish
            save(false)
          end
        end

        def unpublish!
          unpublish
          save(false)
        end
      end
      
      named_scope :published, lambda { |*args|
        if args.first.nil? || TRUE_VALUES.include?(args.first)
          { :conditions => ["#{quoted_table_name}.`published_at` IS NOT NULL AND #{quoted_table_name}.`published_at` <= ?", Time.now.utc] }
        else
          { :conditions => ["#{quoted_table_name}.`published_at` IS NULL OR #{quoted_table_name}.`published_at` > ?", Time.now.utc] }
        end
      }
      
      def self.unpublished
        published(false)
      end
    end
  end
end