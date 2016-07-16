class Prototype < ActiveRecord::Base
  has_many :images
  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images

  validates_presence_of :title, :catch_copy, :concept
end
