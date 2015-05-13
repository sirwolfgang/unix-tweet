class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  has_many :tweets, dependent: :destroy

  accepts_nested_attributes_for :authentications

  before_create do
    self.password = SecureRandom.base64
  end

  def update_avatar!
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
    end

    twitter_user_id = authentications.find_by(provider: 'twitter').uid
    
    begin
      twitter_user = client.user(twitter_user_id.to_i)
    rescue Twitter::Error::NotFound # User has deleted twitter account
      return destroy
    end

    if twitter_user.default_profile_image?
      self.avatar_url = nil
    else
      self.avatar_url = twitter_user.profile_image_url.to_s
    end

    save!
  end
end
