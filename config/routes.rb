# -*- encoding : utf-8 -*-
Weltel::Application.routes.draw do
	# root
	root(:to => "weltel/dashboards#show", :page => 1)

	mount Authentication::Engine => "/authentication"
	mount Sms::Engine => "/sms"
  mount Feedbacker::Engine => "/feedback"

	# admin
	namespace(:weltel) do
    # system
    resource(:system, :only => [:show]) do
      resource(:connection, :only => [:edit, :update]) do
        resource(:test, :only => [:new, :create])
      end
      resource(:version, :only => [:show, :update])
      resources(:logs, :only => [:index, :destroy, :show], :constraints => { :id => /.*/ })
      resources(:help, :only => [:index, :show])
      resource(:data, :only => [:show])
      resource(:demo, :only => [:show])
      resource(:time_zone, :only => [:show])
    end

		# tasks
		resource(:task, :only => []) do
			get(:create_records)
			get(:update_records)
			get(:receive_responses)
		end

		# dashboards
		resource(:dashboard, :only => [:show])
    match('/dashboard/study(/page/:page)', :to => 'dashboards#show', :view => 'study', :defaults => {:page => 1}, :as => :study_dashboard)
    match('/dashboard/clinic(/page/:page)', :to => 'dashboards#show', :view => 'clinic', :defaults => {:page => 1}, :as => :clinic_dashboard)

		# patients
		resources(:patients, :only => [:index, :new, :create, :edit, :update, :destroy]) do
			resources(:messages, :controller => :patient_messages, :only => [:index, :new, :create])
			resources(:checkups, :controller => :patient_checkups, :only => [:update])
		end

		# responses
		resources(:responses, :only => [:index, :new, :create, :edit, :update, :destroy])

		# clinics
		resources(:clinics, :only => [:index, :new, :create, :edit, :update, :destroy])
	end
end
