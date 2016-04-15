class Ranking < ActiveRecord::Base
  include Platformable

  belongs_to :genre
  belongs_to :segment
  has_many :items, -> { order(:rank) },
           autosave: true, validate: true, dependent: :destroy

  validates :genre_id, presence: true
  validates :segment_id, presence: true

  scope :ordered, -> {
    order(platform_name: :desc).order(:genre_id, :segment_id)
  }

  delegate :count, to: :items, prefix: true

  def last_ranking
    @last_ranking ||=
      begin
        q = attributes.slice(*%w(platform_name genre_id segment_id))
        q[:created_on] = (created_on - 7..created_on - 1)
        Ranking.order(created_at: :desc).where(q).limit(1).first
      end
  end
end
