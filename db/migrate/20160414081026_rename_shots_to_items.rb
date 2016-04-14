class RenameShotsToItems < ActiveRecord::Migration
  def change
    rename_table :shots, :items
  end
end
