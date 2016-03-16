class CrawlAppStoreJob < CrawlJob
  PLATFORM = :appstore
  queue_as PLATFORM

  def create_crawler genre, segment
    genre_keys = {}

    PlayStore::AppStore::Crawler.new(
      genre: (genre_keys[genre.name] || genre.name).to_sym,
      segment: segment.name.to_sym
    )
  end
end
