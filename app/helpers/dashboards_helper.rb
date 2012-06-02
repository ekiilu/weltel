# -*- encoding : utf-8 -*-
module DashboardsHelper
  def is_study_dashboard?(view)
    view == 'study'
  end

  def active_class(bool)
    bool ? 'active' : 'inactive'
  end
end
