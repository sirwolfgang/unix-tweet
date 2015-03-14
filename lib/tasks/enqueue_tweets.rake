task :enqueue_tweets do
  Tweet.where(twitter_id: nil).where(['? < scheduled_at', DateTime.now]).where(['? > scheduled_at', DateTime.now + 1.hour]).each do |tweet|
    TweeterWorker.perform_async(tweet.id)
  end
end