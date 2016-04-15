class RenamePlatformToPlatformName < ActiveRecord::Migration
  def change
    rename_column :fetchers, :platform, :platform_name
    rename_column :item_codes, :platform, :platform_name
    rename_column :rankings, :platform, :platform_name
  end
end
