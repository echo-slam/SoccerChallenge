module ApplicationHelper
  def semantic_class_for flash_type
    { success: 'positive message', error: 'negative message', notice: 'warning message', info: 'info message'}[flash_type.to_sym]
  end

  def flash_messages(opts = {})
    flash.map do |msg_type, message|
      content_tag(:div, message, class: "ui #{semantic_class_for(msg_type)}") do
        content_tag(:i, ''.html_safe, class: 'close icon', data: {dismiss: 'message'}) + content_tag(:div, message, class: "header")
      end
    end.join.html_safe
  end
end
