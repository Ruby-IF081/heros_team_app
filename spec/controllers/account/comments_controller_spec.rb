require 'rails_helper'

RSpec.describe Account::CommentsController, type: :controller do
  let!(:comment) { create(:comment) }
  before :each do
    @user = comment.user
    sign_in @user
  end
  describe 'POST create' do
    render_views
    context 'with valid attributes' do
      let!(:val_comment) { build(:comment, user_id: @user.id, tenant_id: @user.tenant_id) }
      it 'should create a new comment' do
        expect do
          post :create, xhr: true, params: { comment:
                                           { commentable_type: val_comment.commentable_type,
                                             commentable_id: val_comment.commentable_id,
                                             user_id: val_comment.user_id,
                                             tenant_id:  val_comment.tenant_id,
                                             body: val_comment.body } }
        end.to change(Comment, :count).by(1)
      end
    end
    context 'with invalid attributes' do
      let!(:invalid_comment) { build(:comment, user_id: @user.id, tenant_id: @user.tenant_id) }
      it 'should not create a new comment' do
        expect do
          post :create, xhr: true, params: { comment:
                                           { commentable_type: invalid_comment.commentable_type,
                                             commentable_id: invalid_comment.commentable_id,
                                             user_id: invalid_comment.user_id,
                                             tenant_id: invalid_comment.tenant_id,
                                             body: ' ' } }
        end.to_not change(Comment, :count)
      end
    end
  end
  describe 'DELETE destroy' do
    render_views
    context 'when user has privilege' do
      it 'should delete the comment' do
        expect do
          delete :destroy, xhr: true, params: { id: comment.id }
        end.to change(Comment, :count).by(-1)
      end
    end
    context 'when user has no privilege' do
      before :each do
        @sale = FactoryBot.create(:user, :sale, tenant_id: @user.tenant_id)
        sign_out @user
        sign_in @sale
      end
      let!(:other_tenant_comment) { create(:comment) }
      it 'should not delete the comment' do
        expect do
          delete :destroy, xhr: true, params: { id: comment.id }
        end.to_not change(Comment, :count)
      end
    end
  end
end
