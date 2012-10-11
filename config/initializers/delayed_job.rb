#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
Delayed::Worker.destroy_failed_jobs = true
Delayed::Worker.max_attempts = 25
Delayed::Worker.backend = :active_record
#Delayed::Worker.logger = ActiveSupport::BufferedLogger.new(File.join(Rails.root, 'log', 'delayed_job.log'))
