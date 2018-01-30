class Account::PagesController < ApplicationController
  def index
    @partial = whitelisted_partial || 'pages_list'
    per_page = @partial == 'pages_list' ? 10 : 12
    @pages = params[:q].blank? ? list_without_params(per_page) : list_with_params(per_page)
    @company = parent
  end

  def show
    @page     = resource
    @company  = parent
  end

  def rate
    @page = resource
    @company = @page.company
    if @page.update_rating(params[:page][:rating])
      redirect_to account_company_pages_path
    else
      flash.now[:danger] = 'Invalid values for rating!'
      render :show
    end
  end

  private

  def parent
    @company ||= current_user.companies.find(params[:company_id])
  end

  def resource
    collection.find(params[:id])
  end

  def collection
    parent.pages
  end

  def list_without_params(per_page)
    collection.by_rating.page(params[:page]).per(per_page)
  end

  def list_with_params(per_page)
    Page.search(params[:q],
                where: { company_id: parent.id },
                page: params[:page],
                per_page: per_page)
  end

  def whitelisted_partial
    %w[pages_list pages_card].detect { |str| str == params[:view] }
  end
end
