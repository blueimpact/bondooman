class ItemFetcher < Fetcher
  validates :platform, inclusion: ItemCode::PLATFORMS
  validates :item_code_id, presence: true
  validates :platform, uniqueness: { scope: [:item_code_id] }

  delegate :code, to: :item_code, prefix: true

  before_validation :save_item_code

  def shots
    Shot.where(item_code_id: item_code_id).order(id: :desc)
  end

  def item_code_code= arg
    self.item_code =
      ItemCode.find_or_initialize_by(platform: platform, code: arg)
    arg
  end

  private

  def save_item_code
    if item_code.present? && item_code.new_record?
      item_code.save
      self.item_code = item_code
    end
  end
end
