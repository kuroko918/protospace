class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]

  def show
    @like = current_user.likes.find_by(prototype_id: params[:id]) if user_signed_in?
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def new
    @prototype = Prototype.new
    @prototype.images.build
  end

  def create
    @prototype = Prototype.new(create_params)
    if @prototype.save
      redirect_to root_path, notice: 'exactly saved'
    else
      render :new
    end
  end

  def edit
    @main_image = @prototype.images.main[0]
    @sub_images = @prototype.images.sub
  end

  def update
    if @prototype.update(update_params)
      redirect_to root_path, notice: 'Updated Successfully'
    else
      render :edit
    end
  end

  def destroy
    if @prototype.destroy
      redirect_to root_path, notice: 'Deleted Successfully'
    else
      render :show
    end
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def set_tag_list
    params[:prototype][:tag_list]
  end

  def create_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      images_attributes: [:image, :status]
      ).merge(user_id: current_user.id, tag_list: set_tag_list)
  end

  def update_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      images_attributes: [:id, :image, :status]
      ).merge(tag_list: set_tag_list)
  end
end
