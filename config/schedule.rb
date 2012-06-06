# -*- encoding : utf-8 -*-
app_root = File.expand_path("#{File.dirname(__FILE__)}/..")
require "#{app_root}/lib/app_config.rb"
AppConfig.load("#{app_root}/config/app_config.yml")

set(:output, "/www/weltel/current/log/cron.log")

every(5.minutes) do
	command("curl #{AppConfig.internal_host}/weltel/task/receive_responses")
end

every(:sunday, :at => "8pm") do
  command("curl #{AppConfig.internal_host}/weltel/task/create_records")
end

every(:tuesday, :at => "8pm") do
  command("curl #{AppConfig.internal_host}/weltel/task/update_records")
end
