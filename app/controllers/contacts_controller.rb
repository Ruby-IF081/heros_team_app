class ContactsController < ApplicationController
  layout "landing"

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(allowed_params)
    if @contact.save
      respond_to_format
    else
      respond_to_format { render :create_error }
    end
  end

  private

  def respond_to_format(&block)
    respond_to { |format| format.js(&block) }
  end

  def allowed_params
    params.require(:contact).permit(:name, :email, :phone, :message)
  end
end
