module BreadcrumbsHelper
  def render_breadcrumbs(breadcrumbs_hash)
    @breadcrumbs ||= []
    breadcrumbs_hash.each do |title, path|
      @breadcrumbs << { title: title, path: path }
    end
    render partial: 'account/shared/breadcrumbs', locals: { nav: @breadcrumbs }
  end
end
