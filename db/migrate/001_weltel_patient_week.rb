migration 1, :weltel_patient_week do

  up do
  	Weltel::Patient.auto_upgrade!(:default)
		Weltel::Patient.all(:week => 0).each do |patient|
			patient.week = 17
			patient.save
		end
  end

  down do
  end
end
