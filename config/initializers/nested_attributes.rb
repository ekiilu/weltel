#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

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

