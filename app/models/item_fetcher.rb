class ItemFetcher < Fetcher
  validates :item_code_id, presence: true
  validates :platform_name, uniqueness: { scope: [:item_code_id] }

  delegate :code, to: :item_code, allow_nil: true, prefix: true

  before_validation :save_item_code

  def items
    Item
      .where(item_code_id: item_code_id, ranking_id: nil)
  end

  def item_code_code= arg
    self.item_code =
      ItemCode.find_or_initialize_by(platform_name: platform_name, code: arg)
    arg
  end

  def to_s
    "#{platform} - #{item_code}"
  end

  private

  def save_item_code
    if item_code.present? && item_code.new_record?
      item_code.save
      self.item_code = item_code
    end
  end
end
