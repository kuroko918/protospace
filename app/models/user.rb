class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :email, :password, :name

  has_many :prototypes

  mount_uploader :avatar, AvatarUploader
end
