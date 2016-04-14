class RenameItemToItemBodyOfFormatters < ActiveRecord::Migration
  def change
    rename_column :formatters, :item, :item_body
  end
end
