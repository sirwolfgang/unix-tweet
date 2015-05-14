# This whole idea is terrible, but it works and I want to go to bed
task enqueue_tweets: :environment do
  User.find_each do |user|
    next if user.twitter_token.nil? || user.twitter_secret.nil? || !user.tweets.empty?

    trigger_time = Time.new(2015, 5, 15, 2, 9, 25).utc

    Tweet.create!(user_id: user.id, scheduled_at: trigger_time)
  end
  
  Tweet.where(twitter_id: nil).where(['scheduled_at < ?', DateTime.now + 10.minutes]).each do |tweet|
    TweeterWorker.perform_async(tweet.id)
  end
end