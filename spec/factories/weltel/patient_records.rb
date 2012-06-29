# -*- encoding : utf-8 -*-
FactoryGirl.define do

  factory(:patient_record, :class => Weltel::PatientRecord) do
  	patient
  	contact_method { Support::Randomizer.array(Weltel::PatientRecord::CONTACT_METHODS) }
  	created_on { Date.today }
  	created_at { DateTime.now }
  	updated_at { DateTime.now }
  end
end
