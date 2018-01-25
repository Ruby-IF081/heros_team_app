class Account::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      respond_to { |format| format.js }
    else
      respond_to { |format| format.js { render js: "alert('Comment is invalid!');" } }
    end
  end

  def destroy
    @comment = resource
    if current_user.privileged?
      @comment.destroy
      respond_to { |format| format.js }
    else
      respond_to { |format| format.js { render js: "alert('No rights to delete this comment');" } }
    end
  end

  private

  def resource
    Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :body, :commentable_type, :commentable_id)
  end
end
