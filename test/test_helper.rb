ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

Dir.glob(File.join(Rails.root, 'app', 'models', '**', '*.rb')).each {|f| require f}
DataMapper.auto_migrate!

class ActiveSupport::TestCase
	#
  setup do
		repository(:default) do
			transaction = DataMapper::Transaction.new(repository)
			transaction.begin
			repository.adapter.push_transaction(transaction)
		end
  end

	#
	teardown do
		repository(:default).adapter.pop_transaction.rollback
	end
end