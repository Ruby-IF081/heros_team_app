class Account::VideosController < ApplicationController
  def index
    @videos = collection.page(params[:page]).per(9)
    @company = parent
  end

  private

  def parent
    @parent ||= current_user.companies.find(params[:company_id])
  end

  def collection
    parent.videos
  end
end
