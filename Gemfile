source "https://vertical:g3m4cc3ss@gems.verticallabs.ca" 
source "http://rubygems.org"

# rails
RAILS_VERSION = "3.2.5"
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
# some fork that updates gemspec to work with dm-core 1.2.0
gem "dm-accepts_nested_attributes", :git => "https://github.com/waelchatila/dm-accepts_nested_attributes.git"

# jquery
gem "jquery-rails"

# development
group(:development) do
	gem "magic_encoding"
end

# assets
group(:assets) do
	gem "coffee-rails"
	gem "haml-rails"
	gem "sass-rails"	
	gem "compass-rails"
	gem "uglifier"
end

# test
group :test do
	gem "rspec-rails"
	gem "factory_girl_rails"	
	gem "database_cleaner"
end

# deploy
gem "execjs"
gem "therubyracer"
gem "capistrano"
gem "unicorn"
gem "thin"

# monitoring
gem "god"

# application
gem "recursive-open-struct"
gem "exception_notification"
gem "whenever", :require => false
gem "delayed_job"
gem "delayed_job_data_mapper", "1.0.0.rc", :git => "https://github.com/collectiveidea/delayed_job_data_mapper.git"
gem "delayed_mail"
gem "vertical-feedbacker", "0.0.2"
gem "will_paginate"

HOME_PATH = File.expand_path('~/mambo/gems')
DEV_GIT = "http://dev.verticallabs.ca/git/mambo/gems"

#gem "mambo-authentication", :path => "#{HOME_PATH}/authentication"
gem "mambo-authentication", :git => "#{DEV_GIT}/authentication.git"
#gem "mambo-authentication", "0.0.7"

#gem "mambo-twilio_adapter", :path => "#{HOME_PATH}/twilio_adapter"
gem "mambo-twilio_adapter", :git => "#{DEV_GIT}/twilio_adapter.git"
#gem "mambo-twilio_adapter", "0.0.12"

#gem "mambo-sms", :path => "#{HOME_PATH}/sms"
gem "mambo-sms", :git => "#{DEV_GIT}/sms.git"
#gem "mambo-sms", "0.0.12"

#gem "mambo-messaging", :path => "#{HOME_PATH}/messaging"
gem "mambo-messaging", :git => "#{DEV_GIT}/messaging.git"
#gem "mambo-messaging", "0.0.5"

#gem "mambo-support", :path => "#{HOME_PATH}/support"
gem "mambo-support", :git => "#{DEV_GIT}/support.git"
#gem "mambo-support", "0.0.1"
