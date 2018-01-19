module GoogleAnalyticsHelper
  def render_google_analytics
    return unless Rails.env.production?
    render 'layouts/shared/google_analytics'
  end
end
