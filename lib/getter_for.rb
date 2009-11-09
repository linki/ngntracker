module GetterFor
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def getter_for(attributes = {})
      attributes.each do |model, methods|
        methods = [methods] unless methods.is_a?(Array)
        methods.each do |method|
          define_method "#{model}_#{method}" do
            send(model).send(method) if send(model) 
          end
        end
      end
    end
    
    def setter_for(attributes = {})
      attributes.each do |model, methods|
        methods = [methods] unless methods.is_a?(Array)
        methods.each do |method|
          define_method "#{model}_#{method}=" do |attribute|
            self.send("#{model}=", model.to_s.camelize.constantize.send("find_or_create_by_#{method}", attribute))
          end
        end
      end
    end
    
    def getter_and_setter_for(attributes = {})
      getter_for(attributes)
      setter_for(attributes)
    end
  end
end