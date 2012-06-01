# -*- encoding : utf-8 -*-
module ParamsHelper
  def session_param(name, context)
    handle_session_param(name, [name], [context, name])
  end

  def sort_param(context)
    handle_session_param(:sort_key, [:sort_key], [context, :sort_key])
    handle_session_param(:sort_order, [:sort_order], [context, :sort_order])
  end

  def filter_param(context)
    handle_session_param(:filter_key, [:filter_key], [context, :filter_key])
    handle_session_param(:filter_value, [:filter_value], [context, :filter_value])
  end

  def valid_sort
    (@sort_key && @sort_order) ? @sort_key.to_sym.send(@sort_order.to_sym) : nil
  end

  def valid_filter
    (@filter_key && @filter_value) ? {@filter_key.to_sym => @filter_value.to_sym} : {}
  end

private
  def handle_session_param(var_name, param_keys, session_keys)
    val = traverse_hash(params, param_keys) || traverse_hash(session, session_keys)
    val = nil if val.blank?
    instance_variable_set("@#{var_name}".to_sym, val)
    traverse_hash(session, session_keys, val)
  end

  def traverse_hash(hash, keys, val = nil)
    keys.inject(hash) do |s, k|
      if k == keys.last
        s[k] = val if val
        return s[k]
      else
        s[k] ||= {}
        s = s[k]
      end
    end
  end
end
