# -*- encoding : utf-8 -*-
FactoryGirl.define do

  factory(:patient_record, :class => Weltel::PatientRecord) do
  	patient
  	contact_method { Support::Randomizer.array(Weltel::PatientRecord::CONTACT_METHODS) }
  	created_on { Date.today }
  	created_at { DateTime.now }
  	updated_at { DateTime.now }

  	factory(:patient_record_with_state) do
			ignore do
        state :unknown
      end

			after(:create) do |patient_record, evaluator|
        FactoryGirl.create_list(:patient_record_state, 1, :patient_record => patient_record, :value => evaluator.state)
      end
  	end
  end
end
