class Ranking < ActiveRecord::Base
  belongs_to :genre
  belongs_to :segment
  has_many :shots, autosave: true, validate: true, dependent: :destroy

  validates :platform, inclusion: Item::PLATFORMS
  validates :genre_id, presence: true
  validates :segment_id, presence: true
end
