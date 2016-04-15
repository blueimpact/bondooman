class RankingFetcher < Fetcher
  validates :genre_id, presence: true
  validates :segment_id, presence: true
  validates :platform_name, uniqueness: { scope: [:genre_id, :segment_id] }

  def rankings
    Ranking
      .where(platform_name: platform_name)
      .where(genre_id: genre_id, segment_id: segment_id)
  end

  def to_s
    "#{platform} - #{genre} - #{segment}"
  end
end
