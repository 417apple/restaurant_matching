class Restaurant < ApplicationRecord
 mount_uploader :cl_image, CloudinaryImageUploader
  validates :name, :cl_image, :comment, :address, :opening, :closing, {presence: true}
  validates :comment, {length: {maximum: 100}}
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user, dependent: :destroy
  mount_uploader :image, ImageUploader
  geocoded_by :address
  after_validation :geocode

end
