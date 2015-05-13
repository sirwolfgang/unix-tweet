task update_users: :environment do
  User.find_each do |user|
    UserUpdateWorker.perform_async(user.id)
  end
end
