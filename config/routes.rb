# -*- encoding : utf-8 -*-
Weltel::Application.routes.draw do
	# root
	root(:to => "Weltel::Patients#index")

	mount Authentication::Engine => "/authentication"
	mount Sms::Engine => "/sms"
  mount Feedbacker::Engine => "/feedback"

	# admin
	namespace(:weltel) do
		# tasks
		resource(:task, :only => []) do
			post(:create_records)
			post(:update_records)
			post(:receive_responses)
		end

		# updates
		resource(:update, :only => [:show]) do
			post(:update)
			get(:status)
		end

		# dashboards
		resource(:dashboard, :only => [:show])

		# patients
		resources(:patients, :only => [:index, :new, :create, :edit, :update, :destroy]) do
			resources(:messages, :controller => :patient_messages, :only => [:index, :new, :create])
		end

		# responses
		resources(:responses, :only => [:index, :new, :create, :edit, :update, :destroy])
	end
end
