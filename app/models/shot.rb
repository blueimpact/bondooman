class Shot < ActiveRecord::Base
  belongs_to :item
  belongs_to :genre
  belongs_to :segment

  validates :item_id, presence: true
  validates :genre_id, presence: true
  validates :segment_id, presence: true

  def download_count
    download_count_min && download_count_max &&
      [download_count_min, download_count_max]
  end

  def download_count= arg
    if arg.blank?
      self.download_count_min = nil
      self.download_count_max = nil
    elsif arg.respond_to? :minmax
      self.download_count_min, self.download_count_max = arg.minmax
    else
      fail ArgumentError, 'argument does not respond to minmax'
    end
  end
end
