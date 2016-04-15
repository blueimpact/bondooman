class ItemCode < ActiveRecord::Base
  include Platformable

  has_many :items, dependent: :destroy

  validates :code, presence: true, uniqueness: { scope: :platform_name }

  delegate :to_s, to: :code
end
