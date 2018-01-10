class Account::PagesController < ApplicationController
  def index
    @pages = collection.page(params[:page]).per(10)
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
    current_user.companies.find(params[:company_id]).pages.by_rating
  end
end
