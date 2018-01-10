module BreadcrumbsHelper
  def render_breadcrumbs(breadcrumbs_hash)
    render partial: 'account/shared/breadcrumbs', locals: { nav: breadcrumbs_hash }
  end
end
