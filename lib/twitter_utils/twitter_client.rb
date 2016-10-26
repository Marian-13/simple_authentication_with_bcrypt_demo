require_relative 'tweet_with_picture'

module TwitterUtils
  class TwitterClient
    # Twitter's search API lets to get a maximum of 100 search results per request
    MAXIMUM_SEARCH_RESULTS = 100

    def initialize
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['CONSUMER_KEY']
        config.consumer_secret     = ENV['CONSUMER_SECRET']
        config.access_token        = ENV['ACCESS_TOKEN']
        config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
      end

      @tweets_with_pictures = []
      @tweets_with_pictures_remaining = 0
      @last_new_tweet_id = nil
      @search_query = nil
    end

    def fetch_tweets_with_pictures(search_query, search_type=nil, count: 5)
      # TODO Right way to track search query modification
      if @search_query != search_query
        @search_query = search_query
        first_fetching(@search_query)
      end

      if @tweets_with_pictures_remaining < count
        # max_id is inclusive
        # TODO
        # new_tweets = @client.user_timeline(search_query, count: MAXIMUM_SEARCH_RESULTS,
        #                                                  max_id: @last_new_tweet_id - 1)
        new_tweets = fetch_new_tweets(@search_query)

        select_tweets_with_pictures_from!(new_tweets)
        @last_new_tweet_id = new_tweets.last.id
      end

      @tweets_with_pictures_remaining -= 5

      # Deletes the first {count} elements and returns array of them (... in range)
      @tweets_with_pictures.slice!(0...count)
    end

    private
      def first_fetching(search_query)
        new_tweets = @client.user_timeline(search_query, count: MAXIMUM_SEARCH_RESULTS)
        select_tweets_with_pictures_from!(new_tweets)
        @last_new_tweet_id = new_tweets.last.id
      end

      # TODO refactor
      def select_tweets_with_pictures_from!(new_tweets)
        new_tweets.each do |tweet|
          unless tweet.media.blank?
            @tweets_with_pictures_remaining += 1
            @tweets_with_pictures << TweetWithPicture.new(tweet)
          end
        end
      end

      # TODO
      def fetch_new_tweets(search_query, search_type=:user_name)
        new_tweets = nil

        case search_type
        when :user_name
          new_tweets = @client.user_timeline(
            search_query,
            count: MAXIMUM_SEARCH_RESULTS,
            max_id: @last_new_tweet_id - 1
          )
        when :tag
          new_tweets = @client.search(
            search_query,
            max_id: @last_new_tweet_id - 1
          ).take(MAXIMUM_SEARCH_RESULTS)
        end

        new_tweets
      end
  end
end
