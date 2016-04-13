class Fetcher < ActiveRecord::Base
  include StiBecome

  belongs_to :genre
  belongs_to :segment

  TYPES = %w(ItemFetcher RankingFetcher)
  validates :type, inclusion: TYPES
end
