class PrototypesController < ApplicationController
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
      redirect_to root_path
    else
      redirect_to new_prototype_path
    end
  end
end
