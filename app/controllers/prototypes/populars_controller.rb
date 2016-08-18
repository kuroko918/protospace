class Prototypes::PopularsController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user, :tags).order("likes_count DESC").page(params[:page])
  end
end
