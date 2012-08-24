source "https://vertical:g3m4cc3ss@gems.verticallabs.ca"
source "http://rubygems.org"

# rails
RAILS_VERSION = "~> 3.2"
gem "rails", RAILS_VERSION
gem "mysql2"

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
	gem "shoulda-matchers"
end

# deploy
gem "execjs"
gem "therubyracer"
gem "capistrano", ">= 2.9.0"
gem "capistrano_colors"
gem "unicorn"
gem "thin"
#gem "certified"

# monitoring
gem "god"
gem "tlsmail", :require => false
gem "certified"

# application
# need git version until this is released: https://github.com/jeffp/enumerated_attribute/pull/45
gem "enumerated_attribute", :git => "https://github.com/jeffp/enumerated_attribute.git"
gem "recursive-open-struct"
gem "exception_notification"
gem "whenever", :require => false
gem "delayed_job"
gem "delayed_job_active_record"
gem "delayed_mail"
gem "vertical-feedbacker", "0.0.2"
gem "will_paginate"
gem "squeel"
gem "active_link_to"

HOME_PATH = File.expand_path("~/mambo/gems")
DEV_GIT = "http://dev.verticallabs.ca/git/mambo/gems"

gem "mambo-authentication", :path => "#{HOME_PATH}/authentication" #MAMBO_LOCAL
#gem "mambo-authentication", :git => "#{DEV_GIT}/authentication.git" #MAMBO_DEV
#gem "mambo-authentication", ">= 0.0.10" #MAMBO_PUBLIC

gem "mambo-twilio_adapter", :path => "#{HOME_PATH}/twilio_adapter" #MAMBO_LOCAL
#gem "mambo-twilio_adapter", :git => "#{DEV_GIT}/twilio_adapter.git" #MAMBO_DEV
#gem "mambo-twilio_adapter", ">= 0.0.13" #MAMBO_PUBLIC

gem "mambo-sms", :path => "#{HOME_PATH}/sms" #MAMBO_LOCAL
#gem "mambo-sms", :git => "#{DEV_GIT}/sms.git" #MAMBO_DEV
#gem "mambo-sms", ">= 0.0.15" #MAMBO_PUBLIC

gem "mambo-messaging", :path => "#{HOME_PATH}/messaging" #MAMBO_LOCAL
#gem "mambo-messaging", :git => "#{DEV_GIT}/messaging.git" #MAMBO_DEV
#gem "mambo-messaging", ">= 0.0.7" #MAMBO_PUBLIC

gem "mambo-support", :path => "#{HOME_PATH}/support" #MAMBO_LOCAL
#gem "mambo-support", :git => "#{DEV_GIT}/support.git" #MAMBO_DEV
#gem "mambo-support", ">= 0.0.9" #MAMBO_PUBLIC
