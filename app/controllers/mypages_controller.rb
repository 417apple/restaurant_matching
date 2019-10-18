class MypagesController < ApplicationController
  def show
    @restaurants = current_user.restaurants.order(id: "DESC")
    @like = current_user.liked_restaurants
    if current_user.followings.exists?
      @follows = current_user.followings
    end
    if current_user.followers.exists?
      @followers = current_user.followers
    end 
  end


end
