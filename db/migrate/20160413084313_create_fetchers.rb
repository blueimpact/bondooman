class CreateFetchers < ActiveRecord::Migration
  def change
    create_table :fetchers do |t|
      t.string :type
      t.string :platform
      t.references :genre, index: true, foreign_key: true
      t.references :segment, index: true, foreign_key: true
      t.json :extras

      t.timestamps null: false
    end
  end
end
