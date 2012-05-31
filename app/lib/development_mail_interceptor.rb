# -*- encoding : utf-8 -*-
class DevelopmentMailInterceptor
	#
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "#{ ENV['USER'] }@verticallabs.ca"
  end
end
