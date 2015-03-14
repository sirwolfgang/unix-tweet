class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  has_many :tweets

  accepts_nested_attributes_for :authentications

  before_create do
    self.password = SecureRandom.base64
  end

  after_update do
    return true if twitter_token.nil? || twitter_secret.nil? || !tweets.empty?

    trigger_time = Time.use_zone(user.timezone) do
      Time.zone.local(2015, 3, 14, 21, 26, 53).utc
    end

    Tweet.create!(user_id: id, scheduled_at: trigger_time)
    true
  end
end
