module TwitterUtils
  class TweetWithPicture
    attr_reader :link, :creation_time, :media_url

    def initialize(tweet)
      @link          = "https://twitter.com/#{tweet.user.name}/status/#{tweet.id}"
      @creation_time = "#{tweet.created_at.day}-#{tweet.created_at.month}-#{tweet.created_at.year}"

      # Google Chrome issue
      # Mixed Content: The page at 'https://boiling-ocean-42227.herokuapp.com/log_out'
      # was loaded over HTTPS, but requested an insecure image
      # 'http://pbs.twimg.com/media/CvVzzpsXgAEi2RL.jpg'.
      # This content should also be served over HTTPS.
      # tweet.media[0].media_url returns 'http://pbs.twimg.com/media/CvVzzpsXgAEi2RL.jpg'
      #
      # TODO Mozilla Firefox
      # The resource at "https://pbs.twimg.com/media/CvVzzpsXgAEi2RL.jpg" was
      # blocked because tracking protection is enabled.
      @media_url     = tweet.media[0].media_url_https
    end
  end
end
