module TableHelper
  def sorted_table_header_tag(sort_key, &block)
    content = capture { yield }.strip
    content_tag(:th) do
      raw(content) +
      content_tag(:div, :class => 'sort') do
        link_to("+", params.merge(:sort_key => sort_key.to_s, :sort_order => 'asc'), :class => 'ascending') +
        link_to("-", params.merge(:sort_key => sort_key.to_s, :sort_order => 'desc'), :class => 'descending')
      end
    end
  end
end
