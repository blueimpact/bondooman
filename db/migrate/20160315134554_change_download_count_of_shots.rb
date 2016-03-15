class ChangeDownloadCountOfShots < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        change_column :shots, :download_count_min, :float
        change_column :shots, :download_count_max, :float
      end
      dir.down do
        change_column :shots, :download_count_min, :integer
        change_column :shots, :download_count_max, :integer
      end
    end
  end
end
