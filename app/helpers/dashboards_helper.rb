# -*- encoding : utf-8 -*-
module DashboardsHelper
  def is_study_dashboard?(view)
    view == :study
  end

	#
  def result_values_tabs_tag
  	Weltel::Result::VALUES.each do |result|
  		content_tag(:div, :class => "tab #{active_class(result == @state && @search.blank?)}") do
  			content_tag(:div, :class => "content") do
  				link_to(t("weltel.patient_record_states.values.#{result}"), params.merge(:state => result, :page => 1), :class => "#{active_class(result == @state.to_sym)} #{result} state")
  			end
  		end
  	end
  end

	#
  def checkup_status_tabs_tag
  end

	#
  def initial_result_tag(result)
  	value = result.nil? ? :pending : result.value
		content_tag(:div, t("weltel.patient_record_states.values.#{value}"), :class => "state #{value}")
  end

	#
	def current_result_form_tag(patient, checkup, result)
    form_for(checkup, :url => weltel_patient_checkup_path(patient, checkup)) do |f|
    	select_tag(:current_result, options_for_select(result_value_options, result.value), :onchange => submit_form, :class => "current_state #{result.value}")
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
