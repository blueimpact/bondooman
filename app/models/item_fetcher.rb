class ItemFetcher < Fetcher
  validates :platform, inclusion: Item::PLATFORMS
  validates :item_id, presence: true
  validates :platform, uniqueness: { scope: [:item_id] }

  delegate :code, to: :item, prefix: true

  before_validation :save_item

  def shots
    Shot.where(item_id: item_id).order(id: :desc)
  end

  def item_code= arg
    self.item = Item.find_or_initialize_by(platform: platform, code: arg)
    arg
  end

  private

  def save_item
    if item.present? && item.new_record?
      item.save
      self.item = item
    end
  end
end
