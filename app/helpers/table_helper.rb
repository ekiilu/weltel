module TableHelper
  def sorted_table_header_tag(sort_key, &block)
    content = capture { yield }.strip
    content_tag(:th) do
      raw(content) +
      content_tag(:div, :class => 'sort') do
        link_to("+", params.merge(:page => 0, :sort_key => sort_key.to_s, :sort_order => 'asc'), :class => 'ascending') +
        link_to("-", params.merge(:page => 0, :sort_key => sort_key.to_s, :sort_order => 'desc'), :class => 'descending')
      end
    end
  end

  def filter_table_header_tag(filter_key, filter_enum, &block)
    content = capture { yield }.strip
    active = filter_key == @filter_key.to_sym && @filter_value
    enum_options = options_for_enum(filter_enum, active ?  @filter_value : nil) # only show current if filter is active

    content_tag(:th) do
      raw(content) +
      content_tag(:div, :class => "filter #{(active ? 'active' : nil)}") do
        form_tag(weltel_responses_path, :method => :get) do
          hidden_field_tag(:page, 0) + 
          hidden_field_tag(:filter_key, filter_key) + 
          select_tag(:filter_value, enum_options, :include_blank => true, :onchange => "javascript: this.form.submit();")
        end
      end
    end
  end
end
