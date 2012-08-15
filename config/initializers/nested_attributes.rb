# -*- encoding : utf-8 -*-
module DataMapper
  module NestedAttributes
    module Model
      def accepts_and_validates_nested_attributes_for(association_name, options = {})
        accepts_nested_attributes_for(association_name, options)
        define_method "save" do
          association = self.send(:"#{association_name}")
          if association && !association.valid?
            association.class.properties.each do |property| 
              errors = association.errors.on(property.name) || []
              errors.each {|e| self.errors.add(property.name, e) }
            end
          end
          super()
        end
      end
    end
  end
end

