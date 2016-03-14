PlayStore.configure do |config|
  config.country = :jp
  config.lang = 'ja_jp'

  config.item_count_max = 20
  config.review_count_max = 10

  config.access_interval = 6
  config.access_interval_proc = -> {
    sleep config.access_interval * (1 + rand)
  }
end
