# -*- encoding : utf-8 -*-
Delayed::Worker.destroy_failed_jobs = true
Delayed::Worker.max_attempts = 25
Delayed::Worker.backend = :data_mapper
Delayed::Worker.logger = ActiveSupport::BufferedLogger.new(File.join(Rails.root, 'log', 'delayed_job.log'))
