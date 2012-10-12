#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
module DashboardsHelper
  def is_study_dashboard?(view)
    view == :study
  end

  #
  def clinical_tabs_tag
  	render(:partial => "clinical_tabs")
  end

	#
  def study_tabs_tag
  	render(:partial => "study_tabs")
  end

	#
  def result_value_tag(result)
  	value = result_value(result)
		content_tag(:div, result_value_t(value), :class => result_value_class(value))
  end

	#
	def result_value_select_tag(patient, checkup, result)
		render(:partial => "result_value_select", :locals => {:patient => patient, :checkup => checkup, :result => result})
	end

	#
  def checkup_status_select_tag(patient, checkup)
		render(:partial => "checkup_status_select", :locals => {:patient => patient, :checkup => checkup})
  end

	#
  def checkup_contact_method_select_tag(patient, checkup)
  	render(:partial => "checkup_contact_method_select", :locals => {:patient => patient, :checkup => checkup})
  end
end
