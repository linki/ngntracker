module Archivable
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def archivable(options = {})
      instance_eval do
        define_method "archived?" do
          !!send(:archived)
        end

        define_method "archived" do
          send(:archived_at) && send(:archived_at) <= Time.now
        end

        define_method "archived=" do |archived|
          if ["true", true, "1", 1].include?(archived)
            write_attribute(:archived_at, Time.now.utc) unless send(:archived?)
          else
            write_attribute(:archived_at, nil) if send(:archived?)
          end
        end
        
        define_method "archive!" do
          send(:update_attribute, :archived_at, Time.now.utc) unless send(:archived?)
        end

        define_method "unarchive!" do
          send(:update_attribute, :archived_at, nil) if send(:archived?)
        end

        named_scope :archived, lambda { |*args|
          if args.first.nil? || ["true", true, "1", 1].include?(args.first)
            { :conditions => ['archived_at IS NOT NULL AND archived_at <= ?', Time.now.utc] }
          else
            { :conditions => ['archived_at IS NULL OR archived_at > ?', Time.now.utc] }
          end
        }
      end
    end
  end
end