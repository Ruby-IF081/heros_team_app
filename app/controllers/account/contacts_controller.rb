class Account::ContactsController < ApplicationController
  before_action :authorize_super_admin!

  def index
    @q = Contact.ransack(params[:q])
    @contacts = @q.result.page(params[:page]).per(20)
  end

  def destroy
    @contact = resource
    if @contact.destroy
      respond_to_format
    else
      respond_to_format { render :destroy_error }
    end
  end

  private

  def respond_to_format(&block)
    respond_to { |format| format.js(&block) }
  end

  def resource
    @contact = Contact.find(params[:id])
  end
end
