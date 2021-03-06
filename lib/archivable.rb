module Archivable
  TRUE_VALUES = ["true", true, "1", 1] unless const_defined?(:TRUE_VALUES)
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def archivable(options = {})
      class_eval do
        def archived?
          !!archived
        end

        def archived
          archived_at && archived_at <= Time.now
        end

        def archived=(boolean)
          TRUE_VALUES.include?(boolean) ? archive : unarchive
        end
        
        def archive
          self.archived_at = Time.now.utc unless archived?
        end
        
        def unarchive
          self.archived_at = nil
        end
      
        def archive!
          unless archived?
            archive
            save(false)
          end
        end

        def unarchive!
          unarchive
          save(false)
        end
      end

      named_scope :archived, lambda { |*args|
        if args.first.nil? || TRUE_VALUES.include?(args.first)
          { :conditions => ["#{quoted_table_name}.`archived_at` IS NOT NULL AND #{quoted_table_name}.`archived_at` <= ?", Time.now.utc] }
        else
          { :conditions => ["#{quoted_table_name}.`archived_at` IS NULL OR #{quoted_table_name}.`archived_at` > ?", Time.now.utc] }
        end
      }
      
      def not_archived
        archived(false)
      end
    end
  end
end