class Fetcher < ActiveRecord::Base
  belongs_to :genre
  belongs_to :segment

  validates :platform, inclusion: Item::PLATFORMS
end
