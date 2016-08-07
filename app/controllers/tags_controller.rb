class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.most_used
  end

  def show
    @prototypes = Prototype.includes(:tags, :user).tagged_with(params[:tag_name])
  end
end
