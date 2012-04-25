migration 1, :weltel_patient_week do

  up do
	begin
  		Weltel::Patient.all.each do |patient|
  			patient.week = 17
  			patient.save
  		end
	end
  end

  down do
  end
end
