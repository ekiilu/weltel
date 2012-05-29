Weltel::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Log error messages when you accidentally call methods on nil
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local = true

	Rails.application.config.default_url_options = {
		:host => '207.81.118.135',
		:port => 3000,
	}

	# action controller
  config.action_controller.perform_caching = false
  config.action_controller.allow_forgery_protection = false
	config.action_controller.default_url_options = config.default_url_options

	# action mailer
  config.action_mailer.raise_delivery_errors = true
  #config.action_mailer.delivery_method = :test
	config.action_mailer.default_url_options = config.default_url_options

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  config.log_level = :debug
end
