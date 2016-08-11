class Prototypes::NewestsController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user, :tags).order("created_at DESC")
  end
end
