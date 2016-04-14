class AddItemToFetchers < ActiveRecord::Migration
  def change
    add_reference :fetchers, :item, index: true, foreign_key: true
  end
end
