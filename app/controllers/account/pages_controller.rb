class Account::PagesController < ApplicationController
  PER_PAGE = 12

  def index
    @partial = whitelisted_partial || 'pages_list'
    @pages = params[:q].blank? ? list_without_params : list_with_params
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

  def new
    @page = Page.new
    @company = parent
  end

  def create
    @pages = collection
    @page = @pages.build(page_params.merge(page_type: Page::BY_AJAX, status: Page::PENDING_STATUS))

    if @page.save
      respond_to_format { render :create, status: :created }
    else
      respond_to_format { render :new }
    end
  end

  private

  def respond_to_format(&block)
    respond_to { |format| format.js(&block) }
  end

  def page_params
    params.require(:page).permit(:title, :source_url)
  end

  def parent
    @company ||= current_user.companies.find(params[:company_id])
  end

  def resource
    collection.find(params[:id])
  end

  def collection
    parent.pages
  end

  def list_without_params
    collection.by_rating.page(params[:page]).per(PER_PAGE)
  end

  def list_with_params
    Page.search(params[:q],
                fields: %i[title source_url content company_id],
                where: { company_id: parent.id },
                page: params[:page],
                per_page: PER_PAGE)
  end

  def whitelisted_partial
    %w[pages_list pages_card].detect { |str| str == params[:view] }
  end
end
