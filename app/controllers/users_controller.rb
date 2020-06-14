class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  	@tweets = @user.tweets
    @favorite_tweets = @user.favorite_tweets
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def search
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
      @users = User.none
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
