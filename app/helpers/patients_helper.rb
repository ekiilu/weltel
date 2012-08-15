# -*- encoding : utf-8 -*-
module PatientsHelper
  def initial_state_tag(patient)
    state_tag(:initial, patient.active_record.initial_state.value)
  end

  def active_state_tag(patient)
    state_tag(:active, patient.active_record.active_state.value)
  end

  def state_tag(name, value)
		content_tag(:div, t("weltel.patient_record_states.values.#{value}"), :class => "state #{value.to_s}")
  end

  def exchange_tag(sent, received, alternates = ['messaging.not_sent', 'messaging.not_received'])
    content_tag(:div, :class => 'exchange') do
      if sent
        content_tag(:div, sent.body, :class => 'sent message')
      elsif alternates[0]
        content_tag(:div, t(alternates[0]), :class => 'null')
      else
        ''
      end.html_safe +
      if received
        content_tag(:div, :class => 'received message') do
          content_tag(:div, :class => 'actions') do
            link_to(weltel_responses_path(:weltel_response => {:value => :positive, :name => u(received.body), :url_encoded => true}), :method => :post, :class => 'positive') do
              content_tag(:span, '+') + t('.mark_positive')
            end +
            link_to(weltel_responses_path(:weltel_response => {:value => :negative, :name => u(received.body), :url_encoded => true}), :method => :post, :class => 'negative') do
              content_tag(:span, '+') + t('.mark_negative') 
            end
          end + 
          content_tag(:div, received.body, :class => 'body')
        end
      elsif alternates[1]
        content_tag(:div, t(alternates[1]), :class => 'null')
      else
        ''
      end.html_safe
    end
  end
end
