# -*- encoding : utf-8 -*-
Weltel::Application.routes.draw do
	# root
	root(:to => "weltel/dashboards#show", :page => 1, :view => :study)

	mount Authentication::Engine => "/authentication"
	mount Sms::Engine => "/sms"
  mount Feedbacker::Engine => "/feedback"

	# admin
	namespace(:weltel) do
		# tasks
		resource(:task, :only => []) do
			get(:create_records)
			get(:update_records)
			get(:receive_responses)
		end

		# updates
		resource(:update, :only => [:show]) do
			post(:update)
			get(:status)
		end

		# dashboards
		resource(:dashboard, :only => [:show]) do
      get(:log)
    end
    match('/dashboard/study(/page/:page)', :to => 'dashboards#show', :view => 'study', :defaults => {:page => 1}, :as => :study_dashboard)
    match('/dashboard/clinic(/page/:page)', :to => 'dashboards#show', :view => 'clinic', :defaults => {:page => 1}, :as => :clinic_dashboard)

		# patients
		resources(:patients, :only => [:index, :new, :create, :edit, :update, :destroy]) do
			resources(:messages, :controller => :patient_messages, :only => [:index, :new, :create])
			resources(:records, :controller => :patient_records, :only => [:update])
		end

		# responses
		resources(:responses, :only => [:index, :new, :create, :edit, :update, :destroy])

		# clinics
		resources(:clinics, :only => [:index, :new, :create, :edit, :update, :destroy])
	end
end
