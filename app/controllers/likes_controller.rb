class LikesController < ApplicationController


  def create
    @restaurant = Restaurant.find_by(params[:restaurant_id])
    @like = current_user.likes.new(restaurant_id: params[:restaurant_id])
    if @like.save
    redirect_to controller: 'restaurants', action: 'show', id: params[:restaurant_id]
    else
    redirect_to controller: 'restaurants', action: 'show', id: params[:restaurant_id], notice: "いいね失敗"
  end
end
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @like = current_user.likes.find_by(restaurant_id: params[:id])
    if @like.destroy
    redirect_to controller: 'restaurants', action: 'show', id: params[:id]
    else
    redirect_to controller: 'restaurants', action: 'show', id: params[:id], notice: "削除失敗"
  end
  end


  private



end
