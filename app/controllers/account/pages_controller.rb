class Account::PagesController < ApplicationController
  def index
    @pages = collection.page(params[:page]).per(10)
    @company = current_company
  end

  def show
    @page = resource
  end

  def rate
    @page = resource
    if @page.update_rating(params[:page][:rating])
      redirect_to account_company_pages_path
    else
      flash.now[:danger] = 'Invalid values for rating!'
      render :show
    end
  end

  private

  def resource
    collection.find(params[:id])
  end

  def collection
    current_company.pages.by_rating
  end

  def current_company
    current_user.companies.find(params[:company_id])
  end
end
