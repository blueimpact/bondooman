class ItemCode < ActiveRecord::Base
  has_many :items, dependent: :destroy

  PLATFORMS = %w(googleplay appstore)

  validates :platform, inclusion: PLATFORMS
  validates :code, presence: true, uniqueness: { scope: :platform }

  delegate :to_s, to: :code
end
