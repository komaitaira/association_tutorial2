class TweetsController < ApplicationController
  before_action :authenticate_user!
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

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def tweet_params
  	params.require(:tweet).permit(:body, :image) #tweetモデルのカラムのみを許可
  end
end
