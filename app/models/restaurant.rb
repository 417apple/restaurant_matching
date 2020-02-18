class Restaurant < ApplicationRecord
  mount_uploader :cl_image, CloudinaryImageUploader
  validates :name, :cl_image, :comment, :address, :opening, :closing, {presence: true}
  validates :comment, {length: {maximum: 100}}
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user, dependent: :destroy
  geocoded_by :address
  after_validation :geocode

  def self.csv_attributes
    ["name", "address","comment","opening","closing", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |restaurant|
        csv << csv_attributes.map{ |attr| restaurant.send(attr) }
      end
    end
  end

end
