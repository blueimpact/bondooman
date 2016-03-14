class CrawlGooglePlayJob < CrawlJob
  PLATFORM = :googleplay
  queue_as PLATFORM

  def genre_keys
    { 'games' => 'game' }
  end
end
