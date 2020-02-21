class RestaurantsController < ApplicationController

before_action :authenticate_user!,{only: [:new, :create, :edit, :update, :destroy]}
before_action :ensure_correct_user,{only:[:edit, :update, :destroy]}
before_action :post_limit,{only:[:new, :create]}

  def index
    if params[:restaurant] == nil
      @restaurants = Restaurant.all.order(id: "DESC").page(params[:page]).per(6)
    elsif params[:restaurant] == ""
      @restaurants = Restaurant.all.order(id: "DESC").page(params[:page]).per(6)
    else
      @restaurants = Restaurant.where("name LIKE ? ",'%' + params[:restaurant] + '%').order(id: "DESC").page(params[:page]).per(6)
    end
    respond_to do |format|
      format.html
      format.csv { send_data @restaurants.generate_csv, filename: "restaurants-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" } # --- ②
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create

    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
     if @restaurant.save
       flash[:notice] = "投稿成功しました"
       redirect_to action: 'index'
     else
       render action: "new"
     end
  end

  def destroy
    Restaurant.find(params[:id]).destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to action: :index
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @users = @restaurant.liked_users.order(id: "DESC")

    @like = Like.new

    @latitude = @restaurant.latitude

    @longitude = @restaurant.longitude

    @address = @restaurant.address
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])


    if @restaurant.update(restaurant_params)
      flash[:notice] = "編集成功しました"
      redirect_to action: "show", id: @restaurant.id
    else
      render action: "edit", id: @restaurant.id
    end
  end

  def ensure_correct_user
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to action: "index"
    end
  end

  def about
  end



  private
  def post_limit
    if current_user.visiter ==1
      flash[:notice] = "権限がありません"
      redirect_to action: "index"
    end
  end



  def restaurant_params
    params.require(:restaurant).permit(:comment, :address, :cl_image, :opening, :closing, :name, :page, :latitude, :longitude)
  end

end
