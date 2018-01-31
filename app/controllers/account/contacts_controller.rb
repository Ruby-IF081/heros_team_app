class Account::ContactsController < ApplicationController
  before_action :authorize_super_admin!
  def index
    @q = Contact.ransack(params[:q])
    @contacts = @q.result.page(params[:page]).per(20)
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render json: { success: true }
  end
end
