class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :platform
      t.string :code

      t.timestamps null: false
    end
  end
end
