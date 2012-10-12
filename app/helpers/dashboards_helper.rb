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
  def result_values_tabs_tag
  	RESULT_VALUES.each do |value|
  		content_tag(:div, :class => "tab #{active_class(value == @state && @search.blank?)}") do
  			content_tag(:div, :class => "content") do
  				link_to(result_value_t(value), params.merge(:state => value, :page => 1), :class => "#{active_class(value == @state.to_sym)} #{value} state")
  			end
  		end
  	end
  end

	#
  def checkup_status_tabs_tag
  end

	#
  def initial_result_tag(result)
  	value = result_value(result)
		content_tag(:div, result_value_t(value), :class => result_value_class(value))
  end

	#
	def current_result_form_tag(patient, checkup, result)
		value = result_value(result)
    form_for(checkup, :url => weltel_patient_checkup_path(patient, checkup)) do |f|
    	select_tag(:current_result, options_for_select(result_value_options, value), :onchange => submit_form, :class => "current_state #{value}")
    end
	end

	#
  def status_tag(patient, checkup)
		form_for(checkup, :url => weltel_patient_checkup_path(patient, checkup)) do |f|
    	select_tag(:status, options_for_select(checkup_status_options, checkup.status), :onchange => submit_form, :class => "status #{checkup.status}")
    end
  end

	#
  def contact_method_tag(patient, checkup)
    form_for(checkup, :url => weltel_patient_checkup_path(patient, checkup)) do |f|
    	select_tag(:contact_method, options_for_select(checkup_contact_method_options, checkup.contact_method), :onchange => submit_form)
    end
  end
end
