
module ActiveRecordExt
  module MultiparameterAssignableAttr 
    extend ActiveSupport::Concern

    included do |base|
      class << base
        def multiparameter_assignable_attr(attr_mappings)      
          @@multiparameter_assignable_attribute_mappings ||= {}
          
          @@multiparameter_assignable_attribute_mappings[self] ||= {}
          
          @@multiparameter_assignable_attribute_mappings[self].merge!(attr_mappings)

          code = <<-CODE
            attr_accessor :#{attr_mappings.keys.join(', ')}

            def self.reflect_on_aggregation(attr_name)
              if @@multiparameter_assignable_attribute_mappings[self].keys.include?(attr_name)
                OpenStruct.new(
                  :klass => @@multiparameter_assignable_attribute_mappings[self][attr_name]
                )
              else 
                super(attr_name)
              end
            end        
          CODE

          class_eval(code)      
        end            
      end
    end
  end
end