class Shot < ActiveRecord::Base
  belongs_to :item
  belongs_to :genre
  belongs_to :segment
end
