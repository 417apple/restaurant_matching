class MypagesController < ApplicationController
  def show
    @restaurants = current_user.restaurants.order(id: "DESC")
    @like = current_user.liked_restaurants
    @follows = current_user.followings
    @followers = current_user.followers

  end


end
