class Account::PagesController < ApplicationController
  def index
    @pages = collection.by_rating.page(params[:page]).per(10)
    @company = parent
  end

  def show
    @page    = resource
    @company = parent
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
end
