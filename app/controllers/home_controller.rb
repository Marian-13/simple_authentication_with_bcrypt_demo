class HomeController < ApplicationController
  before_action :authorize

  def index
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end

    begin
      @tweets = @client.user_timeline('Lamborghini', count: 50)
    rescue Twitter::Error
      render 'TODO Rescue Twitter::Error'
    end
  end
end
