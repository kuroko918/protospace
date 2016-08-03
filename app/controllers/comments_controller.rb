class CommentsController < ApplicationController
  def create
    @prototype = Prototype.find(params[:prototype_id])
    @prototype.comments.create(create_params)
  end

  private

  def create_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id)
  end
end
