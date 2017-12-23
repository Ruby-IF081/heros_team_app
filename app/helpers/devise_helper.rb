module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?
    render 'devise/shared/errors_massages'.html_safe
  end

  private

  def error_messages
    resource.errors.full_messages
  end

  def error_sentence
    I18n.t('errors.messages.not_saved',
           count: resource.errors.count,
           resource: resource.class.model_name.human.downcase)
  end

end
