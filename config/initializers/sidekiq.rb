url = ENV['REDIS_URL'].presence || 'redis://localhost:6379'

Sidekiq.configure_server do |config|
  hash = {
    url: url,
    namespace: "sidekiq_bondooman_#{Rails.env}"
  }
  if size = ENV['REDIS_SERVER_SIZE']
    hash[:size] = size.to_i
  end
  config.redis = hash
end

Sidekiq.configure_client do |config|
  hash = {
    url: url,
    namespace: "sidekiq_bondooman_#{Rails.env}"
  }
  if size = ENV['REDIS_CLIENT_SIZE']
    hash[:size] = size.to_i
  end
  config.redis = hash
end
