class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.string :label
      t.string :name

      t.timestamps null: false
    end
  end
end
