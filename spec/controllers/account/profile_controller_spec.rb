require 'rails_helper'

RSpec.describe Account::ProfileController, type: :controller do
  before :each do
    @user = create(:user)
    sign_in @user
  end

  describe "GET #edit" do
    it "GET returns http success" do
      get :edit
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT #update" do
    it "changes user's attributes" do
      put :update, params: { id: @user.id,
                             user: { first_name: 'Firstname',
                                     last_name: 'Lastname',
                                     email: 'email@mail.com' } }
      @user.reload
      expect(@user.first_name).to eq('Firstname')
      expect(@user.last_name).to eq('Lastname')
      expect(@user.email).to eq('email@mail.com')
    end

    it "redirects to the updated user's profile" do
      put :update, params: { id: @user.id,
                             user: { first_name: 'Firstname',
                                     last_name: 'Lastname',
                                     email: 'email@mail.com' } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to account_user_path(@user)
      expect(controller).to set_flash[:success]
    end
  end
end
