# -*- encoding : utf-8 -*-
set(:output, "/www/weltel/current/log/cron.log")

every(5.minutes) do
	command("curl http://127.0.0.1:3000/weltel/task/receive_responses")
end

every(5.minutes) do
	command("/www/weltel/current/script/weltel_checkups")
end
