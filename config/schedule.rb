# -*- encoding : utf-8 -*-
app_root = File.expand_path("#{File.dirname(__FILE__)}/..")
require "#{app_root}/lib/app_config.rb"
AppConfig.load("#{app_root}/config/app_config.yml")

set(:output, "/www/weltel/current/log/cron.log")

require 'date'
require 'active_support'
require 'active_support/time'
require 'active_support/time_with_zone'
def every_in_time_zone(tz_name, weekday, options, &block)
  h, m = options[:at].split(':')
  utc_offset = ActiveSupport::TimeZone[tz_name].formatted_offset
  wday = Date::DAYNAMES.index(weekday.to_s.capitalize)
  wday = 7 if wday == 0
  sample_date = Date.commercial(2012,10,wday)
  converted = Time.new(sample_date.year, sample_date.month, sample_date.day, h, m, 0, utc_offset).utc
  every(Date::DAYNAMES[converted.wday % 7].downcase.to_sym, :at => converted.strftime('%I:%M%p')) do
    yield
  end
end

every(5.minutes) do
	command("curl #{AppConfig.deployment.internal_host}/weltel/task/receive_responses")
end

every_in_time_zone(AppConfig.time_zone, :sunday, :at => '20:00') do
  command("curl #{AppConfig.deployment.internal_host}/weltel/task/create_records")
end

every_in_time_zone(AppConfig.time_zone, :tuesday, :at => '20:00') do
  command("curl #{AppConfig.deployment.internal_host}/weltel/task/update_records")
end
