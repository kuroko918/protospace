class Prototypes::PopularsController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user, :tags).order("likes_count DESC")
  end
end
