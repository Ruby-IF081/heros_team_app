class Account::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.assign_attributes(tenant_id: current_tenant.id)
    if @comment.save
      respond_to_format
    else
      respond_to_format(render(js: "alert('Comment is invalid!');"))
    end
  end

  def destroy
    @comment = resource
    if current_user.privileged?
      @comment.destroy
      respond_to_format
    else
      respond_to_format(render(js: "alert('No rights to delete this comment');"))
    end
  end

  private

  def respond_to_format(block = nil)
    respond_to { |format| format.js { block } }
  end

  def resource
    current_tenant.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end
end
