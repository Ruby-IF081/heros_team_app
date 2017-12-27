class Account::PagesController < ApplicationController
  def index
    @pages = collection.page(params[:page]).per(10)
  end

  def show
    @page = resource
  end

  private

  def resource
    collection.find(params[:id])
  end

  def collection
    current_user.companies.find(params[:company_id]).pages
  end
end
