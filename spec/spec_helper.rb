# -*- encoding : utf-8 -*-
# This file is copied to spec/ when you run "rails generate rspec:install"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "rspec/autorun"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# rspec
RSpec.configure do |config|
  config.before(:suite) do
		DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
  	Rails.logger.debug(example.full_description)
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

	#
	config.before(:each) do
		sender = double
		sender.stub(:send)
		Weltel::Factory.stub(:sender => sender)
	end

  config.include FactoryGirl::Syntax::Methods
end
