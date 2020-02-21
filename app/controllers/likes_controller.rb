class LikesController < ApplicationController
before_action :set_function

  def create
    @like = current_user.likes.new(restaurant_id: params[:restaurant_id])
    @like.save
  end

  def destroy
    @like = current_user.likes.find_by(restaurant_id: params[:restaurant_id])
    @like.destroy
  end

  def set_function
    @restaurant = Restaurant.find(params[:restaurant_id])
    @id_name =  "#likes_container-#{@restaurant.id}"
  end
end
