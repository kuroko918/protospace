class Prototype < ActiveRecord::Base
  has_many :images, dependent: :destroy
  belongs_to :user
  has_many :likes, dependent: :destroy

  accepts_nested_attributes_for :images, reject_if: :reject_images

  validates_presence_of :title, :catch_copy, :concept

  def reject_images(attributed)
    attributed['image'].blank?
  end

  def main_image
    images.main[0].image
  end

  def all_sub_image
    images.sub
  end
end
