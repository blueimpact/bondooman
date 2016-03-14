class CrawlAppStoreJob < CrawlJob
  PLATFORM = :appstore
  queue_as PLATFORM
end
