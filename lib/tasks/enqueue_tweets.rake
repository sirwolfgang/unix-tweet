# This whole idea is terrible, but it works and I want to go to bed
task enqueue_tweets: :environment do
  User.find_each do |user|
    next if twitter_token.nil? || twitter_secret.nil? || !tweets.empty?

    trigger_time = Time.use_zone(user.timezone) do
      Time.zone.local(2015, 3, 14, 21, 26, 53).utc
    end

    Tweet.create!(user_id: id, scheduled_at: trigger_time)
  end
  
  Tweet.where(twitter_id: nil).where(['? < scheduled_at', DateTime.now]).where(['? > scheduled_at', DateTime.now + 10.minutes]).each do |tweet|
    TweeterWorker.perform_async(tweet.id)
  end
end