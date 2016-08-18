class Prototypes::NewestsController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user, :tags).order("created_at DESC").page(params[:page])
  end
end
