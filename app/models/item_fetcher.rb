class ItemFetcher < Fetcher
  validates :platform, inclusion: Item::PLATFORMS
  validates :item_code, presence: true

  store_accessor :extras, :item_code
end
