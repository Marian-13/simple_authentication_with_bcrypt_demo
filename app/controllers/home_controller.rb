class HomeController < ApplicationController
  before_action :authorize

  def index
    respond_to do |format|
      format.html do
        begin
          @tweets = twitter_client.fetch_tweets_with_pictures('Lamborghini', count: 5)
        rescue Twitter::Error => e
          render plain: "TODO Rescue Twitter::Error #{e.message}"
        end
      end

      format.js do
        begin
          @tweets = twitter_client.fetch_tweets_with_pictures('Lamborghini', count: 5)
        rescue Twitter::Error => e
          render plain: "TODO Rescue Twitter::Error #{e.message}"
        end
      end
    end
  end

  private
    # TODO make helper but render_to_string not visible inside HomeHelper
    def content(tweet)
      render_to_string partial: 'tweet', locals: {
        image_source: tweet.media_url,
        creation_time: tweet.creation_time,
        twitter_user_name: tweet.user_name
      }
    end
    helper_method :content
end
