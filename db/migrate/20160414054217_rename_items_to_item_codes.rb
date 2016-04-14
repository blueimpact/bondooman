class RenameItemsToItemCodes < ActiveRecord::Migration
  def change
    rename_table :items, :item_codes
    rename_column :fetchers, :item_id, :item_code_id
    rename_column :shots, :item_id, :item_code_id
  end
end
