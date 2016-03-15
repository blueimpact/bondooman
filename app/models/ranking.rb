class Ranking < ActiveRecord::Base
  belongs_to :genre
  belongs_to :segment
  has_many :shots, -> { order(:rank) },
           autosave: true, validate: true, dependent: :destroy

  validates :platform, inclusion: Item::PLATFORMS
  validates :genre_id, presence: true
  validates :segment_id, presence: true

  scope :ordered, -> { order(platform: :desc).order(:genre_id, :segment_id) }
end
