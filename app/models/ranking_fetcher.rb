class RankingFetcher < Fetcher
  validates :platform, inclusion: ItemCode::PLATFORMS
  validates :genre_id, presence: true
  validates :segment_id, presence: true
  validates :platform, uniqueness: { scope: [:genre_id, :segment_id] }

  def rankings
    Ranking
      .where(platform: platform, genre_id: genre_id, segment_id: segment_id)
      .order(id: :desc)
  end
end
