class CrawlJob < ActiveJob::Base
  def perform genre, segment
    shot_attributes =
      %w(url title author price image_url rating rating_count download_count)

    crawler = crawler_class.new(
      genre: (genre_keys[genre.name] || genre.name).to_sym,
      segment: segment.name.to_sym
    )

    items = crawler.load_ranking.take(20).each(&:update!)

    ranking = Ranking.new(platform: platform, genre: genre, segment: segment)
    items.each_with_index do |item, i|
      ranking.shots.build(
        {
          item: Item.find_or_create_by(platform: platform, code: item.id),
          genre: genre,
          segment: segment,
          rank: i + 1
        }.merge(item.attributes.slice(*shot_attributes))
      )
    end
    ranking.save!
  end

  def platform
    self.class::PLATFORM
  end

  def crawler_class
    case platform
    when :googleplay
      PlayStore::GooglePlay::Crawler
    when :appstore
      PlayStore::AppStore::Crawler
    end
  end

  def genre_keys
    {}
  end
end
