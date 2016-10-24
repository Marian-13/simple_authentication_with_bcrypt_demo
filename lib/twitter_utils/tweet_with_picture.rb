module TwitterUtils
  class TweetWithPicture
    attr_reader :user_name, :creation_time, :media_url

    def initialize(tweet)
      @user_name     = tweet.user.name
      @creation_time = "#{tweet.created_at.day}-#{tweet.created_at.month}-#{tweet.created_at.year}"
      @media_url     = tweet.media[0].media_url # Important media[0] view docs !!!
    end
  end
end
