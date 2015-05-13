class UserUpdateWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    
    return if user.avatar_url.nil?
    avatar_request = Curl.get(user.avatar_url)

    return if avatar_request.status == '200 OK'
    user.update_avatar!
  end
end
