class RelationshipsController < ApplicationController


  def create
    relationship = params[:relationship]
    @user = User.find(relationship[:follow_id])
    @following = current_user.follow(@user)
    if @following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to controller: 'users', action: 'show', id: @user.id
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to controller: 'users', action: 'show', id: @user.id
    end
  end

  def destroy
    relationship = params[:relationship]
    @user = User.find(relationship[:follow_id])
    @following = current_user.unfollow(@user)
    if @following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to controller: 'users', action: 'show', id: @user.id,:notice => "成功"
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to controller: 'users', action: 'show', id: @user.id ,:notice => "失敗"
    end
  end

  private




end
