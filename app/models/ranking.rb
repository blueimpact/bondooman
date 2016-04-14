class Ranking < ActiveRecord::Base
  belongs_to :genre
  belongs_to :segment
  has_many :shots, -> { order(:rank) },
           autosave: true, validate: true, dependent: :destroy

  validates :platform, inclusion: ItemCode::PLATFORMS
  validates :genre_id, presence: true
  validates :segment_id, presence: true

  scope :ordered, -> { order(platform: :desc).order(:genre_id, :segment_id) }
  ItemCode::PLATFORMS.each do |platform|
    scope platform.to_sym, -> { where(platform: platform) }
  end

  def last_ranking
    @last_ranking ||=
      begin
        q = attributes.slice(*%w(platform genre_id segment_id))
        q[:created_on] = (created_on - 7..created_on - 1)
        Ranking.order(created_at: :desc).where(q).limit(1).first
      end
  end
end
