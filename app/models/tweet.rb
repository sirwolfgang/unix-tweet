class Tweet < ActiveRecord::Base
  belongs_to :user

  def send_tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = user.twitter_token
      config.access_token_secret = user.twitter_secret
    end

    tweet = client.update('At the tweet, the time will be 01010101010101010101010101010101 (Friday May 15 02:09:25 GMT). geektime.tweetypi.co #geektime #unix')

    ActiveRecord::Base.transaction do
      update(twitter_id: tweet.id.to_s, url: tweet.url.to_s)
      user.update(avatar_url: tweet.user.profile_image_url.to_s) unless tweet.user.default_profile_image?
    end
  end
end
