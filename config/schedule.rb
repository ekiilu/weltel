# -*- encoding : utf-8 -*-
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
