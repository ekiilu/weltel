module ParamsHelper
  def session_param(name, context)
    handle_session_param(name, [name], [context, name])
  end

  private
  def handle_session_param(var_name, param_keys, session_keys)
    val = traverse_hash(params, param_keys) || traverse_hash(session, session_keys)
    instance_variable_set("@#{var_name}".to_sym, val)
    traverse_hash(session, session_keys, val)
  end

  def traverse_hash(hash, keys, val=nil)
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
