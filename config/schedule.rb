# -*- encoding : utf-8 -*-
set(:output, "/www/weltel/current/log/cron.log")

every(5.minutes) do
	command("curl http://127.0.0.1:3000/weltel/task/receive_responses")
end

every(:sunday, :at => "8pm") do
  command("curl http://127.0.0.1:3000/weltel/task/create_records")
end

every(:tuesday, :at => "8pm") do
  command("curl http://127.0.0.1:3000/weltel/task/update_records")
end
