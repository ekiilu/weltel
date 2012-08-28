# -*- encoding : utf-8 -*-
module ApplicationHelper
  #
  def home_path(user = nil)
    if user.nil?
      new_session_path
    elsif user.role == :Administrator
      admin_update_path
    elsif user.role == :Clinician
      admin_weltel_patients_path
    else
      new_session_path
    end
  end

  def with_format(format, &block)
    old_formats = formats
    self.formats = [format]
    block.call
    self.formats = old_formats
    nil
  end
end
