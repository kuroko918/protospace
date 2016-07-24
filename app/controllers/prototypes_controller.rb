class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :set_prototype, only: :show

  def index
    @prototypes = Prototype.includes(:user)
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

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def create_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      images_attributes: [:image, :status]
      ).merge(user_id: current_user.id)
  end
end
