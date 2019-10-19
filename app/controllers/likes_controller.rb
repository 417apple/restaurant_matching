class LikesController < ApplicationController


  def create
    @like = current_user.likes.new(restaurant_id: params[:restaurant_id])
    if @like.save
      redirect_to controller: 'restaurants', action: 'show', id: params[:restaurant_id]
    else
      redirect_to controller: 'restaurants', action: 'show', id: params[:restaurant_id], notice: "いいね失敗"
    end
  end
  def destroy
    @like = current_user.likes.find_by(restaurant_id: params[:restaurant_id])
    if @like.destroy
      redirect_to controller: 'restaurants', action: 'show', id: params[:restaurant_id]
    else
      redirect_to controller: 'restaurants', action: 'show', id: params[:restaurant_id], notice: "削除失敗"
    end
  end
end
