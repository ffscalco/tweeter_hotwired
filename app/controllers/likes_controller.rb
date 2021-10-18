class LikesController < ApplicationController
  before_action :set_tweet

  def create
    @tweet.increment!(:likes).save
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@tweet, partial: "tweets/tweet", locals: { tweet: @tweet}) }
      @tweets = Tweet.all.order(created_at: :desc)
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
