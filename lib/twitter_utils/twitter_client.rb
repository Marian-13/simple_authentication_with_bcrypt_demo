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
    end

    def fetch_tweets_with_pictures(user_name, count: 5)
      if @tweets_with_pictures_remaining < count
        # new_tweets = @client.user_timeline(user_name, MAXIMUM_SEARCH_RESULTS)

        new_tweets = @client.user_timeline('Lamborghini', count: MAXIMUM_SEARCH_RESULTS)

        puts '@tweets_with_pictures_remaining'
        puts @tweets_with_pictures_remaining

        puts 'new_tweets.size'
        puts new_tweets.size

        new_tweets.each do |tweet|
          unless tweet.media.blank?
            @tweets_with_pictures_remaining += 1
            @tweets_with_pictures << TweetWithPicture.new(tweet)
          end
        end
      end

      puts '@tweets_with_pictures.size'
      puts @tweets_with_pictures.size

      # Deletes the first {count} elements and returns array of them (... in range)
      puts '@tweets_with_pictures.slice!(0..count)'
      q = @tweets_with_pictures.slice!(0...count)
      puts q.size

      # @tweets_with_pictures.slice!(0...count)
      q
    end

    def user_timeline(user_name, count: 5)
      # stub
      @client.user_timeline('Lamborghini', count: 100)
    end
  end
end
