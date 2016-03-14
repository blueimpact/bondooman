class Genre < ActiveRecord::Base
  has_many :shots

  validates :name, presence: true

  def to_s
    label
  end
end
