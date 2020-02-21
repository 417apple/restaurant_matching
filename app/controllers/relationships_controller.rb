class RelationshipsController < ApplicationController


  def create
    relationship = params[:relationship]
    @user = User.find(relationship[:follow_id])
    @following = current_user.follow(@user)
    if @following.save
      flash[:success] = 'ユーザーをフォローしました'
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
    end
  end

  def destroy
    relationship = params[:relationship]
    @user = User.find(relationship[:follow_id])
    @following = current_user.unfollow(@user)
    if @following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
    end
  end

  private




end
