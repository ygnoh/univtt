module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.messages.values.map { |msg| content_tag(:li, msg[0]) }.join
    html = <<-HTML
    <div class="alert alert-error" roll="alert"> <button type="button"
		class="close" data-dismiss="alert">✖<</button>
			#{messages}
    </div>
    HTML

    html.html_safe
  end
end
