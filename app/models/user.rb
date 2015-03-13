class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  
  before_create do
    self.password = SecureRandom.base64
  end
  
  def tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = twitter_token
      config.access_token_secret = twitter_secret
    end
    
    client.update("I really hope this test tweet works the 1st time")
  end
end
