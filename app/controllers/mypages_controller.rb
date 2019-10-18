class MypagesController < ApplicationController
  def show
    @restaurants = current_user.restaurants.order(id: "DESC")
    @like = current_user.liked_restaurants
  

  end


end
