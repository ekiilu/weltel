# -*- encoding : utf-8 -*-
DataMapper::Model.raise_on_save_failure = true
DataMapper.setup(:default, "mysql://dev:mysql@127.0.0.1")
DataMapper.setup(:in_memory, :adapter => "in_memory")

class DataMapper::SaveFailureError
	def to_s
		super + " " + resource.errors.inspect
	end
end

module DataMapper
  module Model
    module Scope
      def query
        if Query === current_scope
          current_scope.dup.freeze
        else
          repository.new_query(self, current_scope).freeze
        end
      end

      protected

      # There is currently a bug in the scoping code for dm-core which hasn't
      # yet been addressed. This is my hack to get everything working as we
      # need it to.
      #
      # [ http://datamapper.lighthouseapp.com/projects/20609/tickets/1354 ]
      def with_scope_with_and(query, &block)
        if Query === query && Query::Conditions::AbstractOperation === query.conditions
          query = query.dup
          scope_stack = self.scope_stack
          scope_stack << query

          begin
            yield
          ensure
            scope_stack.pop
          end

        else
          with_scope_without_and(query, &block)
        end
      end
      alias_method_chain :with_scope, :and

      public
    end
  end
end
