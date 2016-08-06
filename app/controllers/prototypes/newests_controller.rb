class Prototypes::NewestsController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user).order("created_at DESC")
  end
end
