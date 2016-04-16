url = ENV['REDIS_URL'].presence || 'redis://localhost:6379'
app_name = Rails.application.class.parent.name.underscore

Sidekiq.configure_server do |config|
  config.redis = {
    url: url,
    namespace: "sidekiq_#{app_name}_#{Rails.env}",
    size: ENV['REDIS_SERVER_SIZE'].try(&:to_i) || 20
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: url,
    namespace: "sidekiq_#{app_name}_#{Rails.env}",
    size: ENV['REDIS_CLIENT_SIZE'].try(&:to_i) || 1
  }
end
