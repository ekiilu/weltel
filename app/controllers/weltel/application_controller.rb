# -*- encoding : utf-8 -*-
require "dm-rails/middleware/identity_map"

module Weltel
	class ApplicationController < ActionController::Base
		use Rails::DataMapper::Middleware::IdentityMap
		protect_from_forgery
	end
end
