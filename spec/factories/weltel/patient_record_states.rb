# -*- encoding : utf-8 -*-
FactoryGirl.define do

  factory(:patient_record_state, :class => Weltel::PatientRecordState) do
  	record { FactoryGirl.create(:patient_record) }
  	user
  	active true
  	value :positive
  	created_at { DateTime.now }
	end
end
