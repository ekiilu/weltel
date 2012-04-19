source "http://rubygems.org"

# rails
RAILS_VERSION = "~> 3.1"
gem "rails", RAILS_VERSION

# datamapper
DM_VERSION = "~> 1.2"
gem "dm-rails", DM_VERSION
gem "dm-mysql-adapter", DM_VERSION
gem "dm-migrations", DM_VERSION
gem "dm-types", DM_VERSION
gem "dm-validations", DM_VERSION
gem "dm-constraints", DM_VERSION
gem "dm-transactions", DM_VERSION
gem "dm-aggregates", DM_VERSION
gem "dm-timestamps", DM_VERSION
gem "dm-observer", DM_VERSION
gem "dm-serializer", DM_VERSION
gem "dm-pager"
# some fork that updates gemspec to work with dm-core 1.2.0
gem "dm-accepts_nested_attributes", :git => "https://github.com/waelchatila/dm-accepts_nested_attributes.git"

# application
gem "twilio-rb"
gem "feedbacker", :git => "http://dev.verticallabs.ca/git/feedbacker.git"
gem "exception_notification"

# jquery
gem "jquery-rails"

# assets
group(:assets) do
	gem "coffee-rails"
	gem "haml-rails"
	gem "sass-rails"	
	gem "compass-rails"
	gem "uglifier"
end

# test
group(:test) do
	gem "factory_girl_rails"
end

# deploy
gem "execjs"
gem "therubyracer"
gem "capistrano"
gem "unicorn"
gem "thin"

gem "mambo-authentication", :path => "/home/cdion/mambo/gems/authentication"
#gem "mambo-authentication", :git => "http://dev.verticallabs.ca/git/mambo/gems/authentication.git"

gem "mambo-authorization", :path => "/home/cdion/mambo/gems/authorization"
#gem "mambo-authorization", :git => "http://dev.verticallabs.ca/git/mambo/gems/authorization.git"

#gem "mambo-twilio_adapter", :path => "/home/cdion/mambo/gems/twilio_adapter"
gem "mambo-twilio_adapter", :git => "http://dev.verticallabs.ca/git/mambo/gems/twilio_adapter.git"

gem "mambo-sms", :path => "/home/cdion/mambo/gems/sms"
#gem "mambo-sms", :git => "http://dev.verticallabs.ca/git/mambo/gems/sms.git"

#gem "mambo-messaging", :path => "/home/cdion/mambo/gems/messaging"
gem "mambo-messaging", :git => "http://dev.verticallabs.ca/git/mambo/gems/messaging.git"