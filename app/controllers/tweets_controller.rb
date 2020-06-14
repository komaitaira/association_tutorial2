class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def new
  	@tweet = Tweet.new #新規投稿用の空のインスタンス
  end

  def create
  	@tweet = Tweet.new(tweet_params)
  	@tweet.user_id = current_user.id
  	if @tweet.save
  	  redirect_to tweets_path
    else
      render :new
    end
  end

  def index
  	@tweets = Tweet.all.page(params[:page]) #ページング機能追加の記述
  end

  def show
  	@tweet = Tweet.find(params[:id])
  	@user = @tweet.user
    @comment = Comment.new
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path
  end

  private
  def tweet_params
  	params.require(:tweet).permit(:body, :image) #tweetモデルのカラムのみを許可
  end

  def correct_user
    tweet = Tweet.find(params[:id])
    if tweet.user_id != current_user.id
      redirect_to tweets_path
    end
  end
end
