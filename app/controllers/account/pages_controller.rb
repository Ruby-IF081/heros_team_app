class Account::PagesController < ApplicationController
  def index
    @pages = collection.page(params[:page]).per(10)
  end

  def show
    @page = resource
  end

  def rate
    @page = resource
    points = params[:commit]
    last_rating = @page.rating
    if Page::LEGAL_RATING.include?(points)
      @page.update_attribute(:rating, last_rating + points.to_i)
      redirect_to  account_company_pages_path
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
