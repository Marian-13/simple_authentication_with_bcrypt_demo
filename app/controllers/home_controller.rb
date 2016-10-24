class HomeController < ApplicationController
  before_action :authorize

  def index
    respond_to do |format|
      format.html do
        begin
          # @tweets = twitter_client.user_timeline('Lamborghini', count: 50)
          @tweets = twitter_client.fetch_tweets_with_pictures('Lamborghini', count: 5)
        rescue Twitter::Error => e
          render plain: "TODO Rescue Twitter::Error #{e.message}"
        end
      end

      # format.js do
      #
      # end
    end
  end
end
