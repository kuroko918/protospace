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
  end
end
