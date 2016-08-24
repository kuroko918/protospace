class Image < ActiveRecord::Base
  belongs_to :prototype

  validates_presence_of :image, :status

  mount_uploader :image, ImageUploader
  enum status: %i(main sub)
end
