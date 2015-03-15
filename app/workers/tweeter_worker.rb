class TweeterWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)

    return if tweet.twitter_id.present?
    #tweet.with_lock do  Doesnt work with pgbouncer...
    #  next if tweet.twitter_id.present?

    sleep(tweet.scheduled_at - Time.now) while tweet.scheduled_at > Time.now

    begin
      tweet.send_tweet
    rescue Twitter::Error::Unauthorized
      tweet.update(twitter_id: 'Unauthorized')
    end
    #end
  end
end
