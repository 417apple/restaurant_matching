class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 mount_uploader :cl_image, CloudinaryImageUploader
 has_many :restaurants, dependent: :destroy

 has_many :likes, dependent: :destroy
 has_many :liked_restaurants, through: :likes, source: :restaurant

 has_many :messages, dependent: :destroy
 has_many :entries, dependent: :destroy


 validates :comment, length: { maximum: 200 }

 validates :email, {uniqueness: true}

 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

 def already_liked?(restaurant)
    self.likes.exists?(restaurant_id: restaurant.id)
 end

 has_many :relationships
 has_many :followings, through: :relationships, source: :follow
 has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
 has_many :followers, through: :reverse_of_relationships, source: :user

 def follow(other_user)
     unless self == other_user
       self.relationships.find_or_create_by(follow_id: other_user.id)
     end
 end

 def unfollow(other_user)
     @relationship = self.relationships.find_by(follow_id: other_user.id)
     @relationship.destroy!
 end

 def following?(other_user)
     self.followings.include?(other_user)
 end




 def self.find_for_oauth(auth)
   user = User.where(uid: auth.uid, provider: auth.provider).first

   unless user
     user = User.create(
       uid:      auth.uid,
       provider: auth.provider,
       email:    auth.info.email,
       password: Devise.friendly_token[0, 20]
     )
   end

   user
 end

 private

 def self.dummy_email(auth)
   "#{auth.uid}-#{auth.provider}@example.com"
 end

end
