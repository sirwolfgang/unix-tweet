class TweeterWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)

    return if tweet.twitter_id.present?
    tweet.with_lock do
      next if tweet.twitter_id.present?

      sleep(tweet.scheduled_at - Time.now) while tweet.scheduled_at > Time.now

      tweet.send_tweet
    end
  end
end
