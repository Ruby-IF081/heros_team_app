class Account::ChromeExtensionController < ApplicationController
  before_action :authenticate_user!

  def new
    @page = Page.new(source_url: params[:source_url],
                     title: params[:title])
  end

  def create
    @page = Page.create(page_params)
    @page.page_type = Page::CHROME_EXTENSION
    @page.status = Page::PENDING_STATUS
    if @page.save
      flash[:success] = 'Page successfully added'
      redirect_to account_company_pages_path(@page.company)
    else
      render :new
    end
  end

  private

  def page_params
    params.require(:page).permit(:title, :source_url, :company_id)
  end
end
