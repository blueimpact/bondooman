class Segment < ActiveRecord::Base
  has_many :shots

  validates :name, presence: true
end