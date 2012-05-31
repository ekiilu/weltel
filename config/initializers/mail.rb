# -*- encoding : utf-8 -*-
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "verticallabs.ca",
  :user_name            => "site@verticallabs.ca",
  :password             => "v3rt1c4l",
  :authentication       => "plain",
  :enable_starttls_auto => true,
  :tls									=> true
}

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_url_options = { :host => '127.0.0.1', :port => 3000 }

# intercept mail in dev
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?


