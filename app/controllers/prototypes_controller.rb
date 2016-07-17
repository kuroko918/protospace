class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
  end

  def show
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
      redirect_to new_prototype_path, alert: 'please post image'
    end
  end

  private

  def create_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      images_attributes: [:image, :status]
      ).merge(user_id: current_user.id)
  end
end
