class Item < ActiveRecord::Base
  has_many :shots, dependent: :destroy

  PLATFORMS = %w(googleplay appstore)

  validates :platform, inclusion: PLATFORMS
  validates :code, presence: true, uniqueness: { scope: :platform }
end
