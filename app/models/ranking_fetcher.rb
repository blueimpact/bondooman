class RankingFetcher < Fetcher
  validates :platform, inclusion: Item::PLATFORMS
  validates :genre_id, presence: true
  validates :segment_id, presence: true
  validates :platform, uniqueness: { scope: [:genre_id, :segment_id] }
end
