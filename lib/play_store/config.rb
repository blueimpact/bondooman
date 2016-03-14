require 'active_support/configurable'

module PlayStore
  include ActiveSupport::Configurable

  config_accessor :country, :lang
  config_accessor :item_count_max, :review_count_max
  config_accessor :access_interval, :access_interval_proc

  configure do |config|
    config.country = :jp
    config.lang = 'ja_jp'

    config.item_count_max = 200
    config.review_count_max = 500

    config.access_interval = 1
    config.access_interval_proc = -> {
      sleep config.access_interval * (1 + rand)
    }
  end
end
