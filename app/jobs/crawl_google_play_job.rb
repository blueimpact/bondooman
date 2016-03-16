class CrawlGooglePlayJob < CrawlJob
  PLATFORM = :googleplay
  queue_as PLATFORM

  def create_crawler genre, segment
    genre_keys = { 'games' => 'game' }

    PlayStore::GooglePlay::Crawler.new(
      genre: (genre_keys[genre.name] || genre.name).to_sym,
      segment: segment.name.to_sym
    ).tap do |crawler|
      if ENV['TOKYO_PROXY'].present?
        uri = URI.parse ENV['TOKYO_PROXY']
        if uri.user && uri.password
          crawler.agent.set_proxy uri.host, uri.port, uri.user, uri.password
        else
          crawler.agent.set_proxy uri.host, uri.port
        end
      end
    end
  end
end
