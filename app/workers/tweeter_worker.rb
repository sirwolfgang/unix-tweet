class TweeterWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    
    trigger_time = Time.use_zone(user.timezone) do
      Time.zone.local(2015, 3, 14, 21, 26, 53).utc
    end
    
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = user.twitter_token
      config.access_token_secret = user.twitter_secret
    end

    while trigger_time > Time.now do
      sleep(trigger_time - Time.now)
    end
    
    client.update('Happy Pi Day! 3.14.15 9:26:53 #onceinalifetime')
  end
end
