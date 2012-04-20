Weltel::Application.routes.draw do
	# root
	root(:to => "Weltel::Patients#index")

	mount Authentication::Engine => "/authentication"
	mount Authorization::Engine => "/authorization"
	mount Sms::Engine => "/sms"
  mount Feedbacker::Engine => "/feedback"

	# admin
	namespace(:weltel) do
		resource(:task, :only => []) do
			post(:reminders)
			post(:responses)
		end

		# admin controller
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
	end
end
