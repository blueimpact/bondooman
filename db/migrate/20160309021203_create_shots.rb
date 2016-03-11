class CreateShots < ActiveRecord::Migration
  def change
    create_table :shots do |t|
      t.references :item, index: true, foreign_key: true
      t.references :genre, index: true, foreign_key: true
      t.references :segment, index: true, foreign_key: true
      t.integer :rank
      t.string :url
      t.string :title
      t.string :author
      t.integer :price
      t.string :image_url
      t.float :rating
      t.integer :rating_count
      t.integer :download_count_min
      t.integer :download_count_max

      t.timestamps null: false
    end
  end
end
