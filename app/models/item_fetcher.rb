class ItemFetcher < Fetcher
  validates :platform, inclusion: Item::PLATFORMS
  validates :item_code, presence: true

  store_accessor :extras, :item_code

  def shots
    Shot.joins(:item).where(items: { code: item_code }).order(id: :desc)
  end
end
