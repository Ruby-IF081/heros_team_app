class ContactsController < ApplicationController
  layout "landing"
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(allowed_params)
    respond_to do |format|
      if @contact.save
        format.js
      else
        format.json { render json: { errors: @contact.errors.full_messages }, status: 422 }
      end
    end
  end

  private

  def allowed_params
    params.require(:contact).permit(:name, :email, :phone, :message)
  end
end
