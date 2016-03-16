class CrawlJob < ActiveJob::Base
  def perform genre, segment
    shot_attributes =
      %w(url title author price image_url rating rating_count download_count)

    crawler = create_crawler(genre, segment)
    items = crawler.load_ranking.take(20).map { |item| crawler.find item.id }

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
end
