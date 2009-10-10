module GetterFor
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def getter_for(*args)
      attributes = args.extract_options!      
      attributes.each do |model, methods|
        methods = [methods] unless methods.is_a?(Array)
        methods.each do |method|
          define_method "#{model}_#{method}" do
            send(model).send(method) if send(model) 
          end
        end
      end
    end
    
    def setter_for(*args)
      attributes = args.extract_options!
      attributes.each do |model, methods|
        methods = [methods] unless methods.is_a?(Array)
        methods.each do |method|
          define_method "#{model}_#{method}=" do |attribute|
            self.send("#{model}=", model.to_s.camelize.constantize.send("find_or_create_by_#{method}", attribute))
          end
        end
      end
    end
    
    def getter_and_setter_for(*args)
      getter_for(*args)
      setter_for(*args)
    end
  end
end