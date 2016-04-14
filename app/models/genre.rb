class Genre < ActiveRecord::Base
  has_many :items

  validates :name, presence: true

  def to_s
    label
  end
end
