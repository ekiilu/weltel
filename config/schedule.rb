# -*- encoding : utf-8 -*-
set(:output, "/www/weltel/current/log/cron.log")

every(5.minutes) do
	command("/www/weltel/current/script/weltel_responses")
end

every(5.minutes) do
	command("/www/weltel/current/script/weltel_checkups")
end
