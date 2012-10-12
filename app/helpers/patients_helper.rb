#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
module PatientsHelper
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
