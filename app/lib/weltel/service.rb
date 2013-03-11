#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Weltel
	class Service < Messaging::Service
		# instance methods
		# archive checkups
		def archive_checkups(date)
			ActiveRecord::Base.transaction do
				# all current checkups created before date
				checkups = Weltel::Checkup
					.current
					.created_before(date)
				checkups.each do |checkup|
					checkup.archive
				end
			end
		end

		# create checkups
		def create_checkups(date)
			archive_checkups(date)

			body = Sms::MessageTemplate.get_by_name(:checkup).body

			patients = Weltel::Patient
				.active
				.with_active_subscriber
				.without_current_checkup

			patients += Weltel::Patient
				.active
				.with_current_checkup_not_created_on(date)

			patients.each do |patient|
				ActiveRecord::Base.transaction do
					checkup = patient.create_checkup(date)
					message = checkup.send_message(body)
					sender.send(message)
				end
			end
		end

		# update checkups
		def update_checkups
			ActiveRecord::Base.transaction do
				checkups = Weltel::Checkup
					.current
					.without_current_result

				checkups.each do |checkup|
					checkup.create_result(:late, AppConfig.system_user)
				end
			end
		end
	end
end
