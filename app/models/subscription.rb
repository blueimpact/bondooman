class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :formatter
  belongs_to :ranking_fetcher
  belongs_to :item_fetcher
  has_many :publications, dependent: :destroy

  validates :user_id, presence: true
  validates :formatter_id, presence: true
  validates :ranking_fetcher_id, presence: true
end
