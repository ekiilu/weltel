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

# BLAH: https://github.com/cowboyd/therubyracer/issues/215
gem "libv8", "~> 3.3.10"
gem "therubyracer", "0.10.2"

gem "capistrano", ">= 2.9.0"
gem "capistrano_colors"
gem "unicorn"
gem "thin"

# monitoring
gem "god"
gem "tlsmail", :require => false
gem "certified"

# application
gem "enumerated_attribute"
gem "recursive-open-struct"
gem "exception_notification"
gem "whenever", :require => false
gem "delayed_job"
gem "delayed_job_active_record"
gem "delayed_mail", :git => "https://github.com/verticallabs/delayed_mail.git"
gem "will_paginate"
gem "active_link_to"
gem "squeel"

HOME_PATH = File.expand_path("~/mambo/gems")
DEV_GIT = "https://github.com/verticallabs"

#gem "mambo-authentication", :path => "#{HOME_PATH}/authentication" #MAMBO_LOCAL
gem "mambo-authentication", :git => "#{DEV_GIT}/mambo-authentication.git", :branch => 'ar' #MAMBO_DEV
#gem "mambo-authentication", ">= 0.0.10" #MAMBO_PUBLIC

#gem "mambo-adapters", :path => "#{HOME_PATH}/adapters" #MAMBO_LOCAL
gem "mambo-adapters", :git => "#{DEV_GIT}/mambo-adapters.git", :branch => 'ar' #MAMBO_DEV
#gem "mambo-adapters", ">= 0.0.13" #MAMBO_PUBLIC

#gem "mambo-sms", :path => "#{HOME_PATH}/sms" #MAMBO_LOCAL
gem "mambo-sms", :git => "#{DEV_GIT}/mambo-sms.git", :branch => 'ar' #MAMBO_DEV
#gem "mambo-sms", ">= 0.0.15" #MAMBO_PUBLIC

#gem "mambo-messaging", :path => "#{HOME_PATH}/messaging" #MAMBO_LOCAL
gem "mambo-messaging", :git => "#{DEV_GIT}/mambo-messaging.git", :branch => 'ar' #MAMBO_DEV
#gem "mambo-messaging", ">= 0.0.7" #MAMBO_PUBLIC

#gem "mambo-support", :path => "#{HOME_PATH}/support" #MAMBO_LOCAL
gem "mambo-support", :git => "#{DEV_GIT}/mambo-support.git", :branch => 'ar' #MAMBO_DEV
#gem "mambo-support", ">= 0.0.9" #MAMBO_PUBLIC
