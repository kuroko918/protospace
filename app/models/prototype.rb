class Prototype < ActiveRecord::Base
  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

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

  def liked_by?(user)
    likes.find_by(user_id: user)
  end
end
