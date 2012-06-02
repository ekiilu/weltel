# -*- encoding : utf-8 -*-
module PatientsHelper
  def state(patient)
    t(".#{patient.active_record.active_state.value}")
  end
end
