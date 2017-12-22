module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?
    html = html_var
    html.html_safe
  end

  private

  def error_messages
    resource.errors.full_messages.map do |msg|
      content_tag(:li, msg)
    end.join
  end

  def error_sentence
    I18n.t('errors.messages.not_saved',
           count: resource.errors.count,
           resource: resource.class.model_name.human.downcase)
  end

  def html_var
    <<-HTML
    <div class="alert alert-danger alert-dismissible mb-2" role="alert">
       <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
        </button>
        <h5 class="alert-heading mb-2">Warning!</h5>
        <p>#{error_sentence}</p>
           #{error_messages}
    </div>
    HTML
  end
end
