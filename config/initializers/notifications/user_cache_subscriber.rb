ActiveSupport::Notifications.subscribe('user.change') do |name, start, finish, id, payload|
  cache_key = "#{payload[:user_type]}_cache_#{payload[:administration_id]}"

  Rails.cache.delete(cache_key)

  Rails.cache.write(cache_key, User.where(administration_id: administration_id, user_type: user_type))
end