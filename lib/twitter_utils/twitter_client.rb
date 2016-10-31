require_relative 'tweet_with_picture'

module TwitterUtils
  class TwitterClient
    # Twitter's search API lets to get a maximum of 100 search results per request
    MAXIMUM_SEARCH_RESULTS = 100
    # TODO SEARCH_TYPES = [:user_name, :tag]

    def initialize
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['CONSUMER_KEY']
        config.consumer_secret     = ENV['CONSUMER_SECRET']
        config.access_token        = ENV['ACCESS_TOKEN']
        config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
      end
    end

    def fetch_tweets_with_pictures(new_search_query, search_type, count: 5)
      if @last_search_query != new_search_query
        first_fetching(new_search_query, search_type)
      end

      if @tweets_with_pictures_remaining < count
        fetching(new_search_query, search_type)
      end

      @tweets_with_pictures_remaining -= count
      # Deletes the first {count} elements and returns array of them (... in range)
      @tweets_with_pictures.slice!(0...count)
    end

    private
      def first_fetching(search_query, search_type)
        new_tweets = fetch_first_new_tweets(search_query, search_type)

        @last_search_query = search_query
        @last_new_tweet_id = new_tweets.last.id
        @tweets_with_pictures = select_tweets_with_pictures_from(new_tweets)
        @tweets_with_pictures_remaining = @tweets_with_pictures.length
      end

      def fetch_first_new_tweets(search_query, search_type)
        method("search_first_tweets_by_#{search_type}").call(search_query)
      end

      def search_first_tweets_by_user_name(search_query)
        @client.user_timeline(search_query, count: MAXIMUM_SEARCH_RESULTS)
      end

      def search_first_tweets_by_tag(search_query)
        @client.search("##{search_query}").take(MAXIMUM_SEARCH_RESULTS)
      end

      def fetching(search_query, search_type)
        new_tweets = fetch_new_tweets(search_query, search_type)

        @last_new_tweet_id = new_tweets.last.id
        @tweets_with_pictures.concat(select_tweets_with_pictures_from(new_tweets))
        @tweets_with_pictures_remaining = @tweets_with_pictures.length
      end

      # Allowed search types :user_name, :tag
      def fetch_new_tweets(search_query, search_type)
        # max_id is inclusive
        new_tweets = method("search_tweets_by_#{search_type}").call(search_query)
      end

      def search_tweets_by_user_name(search_query)
        @client.user_timeline(
          search_query,
          count: MAXIMUM_SEARCH_RESULTS,
          max_id: @last_new_tweet_id - 1
        )
      end

      def search_tweets_by_tag(search_query)
        @client.search(
          "##{search_query}",
          max_id: @last_new_tweet_id - 1
        ).take(MAXIMUM_SEARCH_RESULTS)
      end

      def select_tweets_with_pictures_from(new_tweets)
        tweets_with_pictures = []

        new_tweets.each do |tweet|
          unless tweet.media.blank?
            tweets_with_pictures << TweetWithPicture.new(tweet)
          end
        end

        tweets_with_pictures
      end
  end
end
