class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.string :platform
      t.references :genre, index: true, foreign_key: true
      t.references :segment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
