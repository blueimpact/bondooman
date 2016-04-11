class CreateFormatters < ActiveRecord::Migration
  def change
    create_table :formatters do |t|
      t.text :item, default: '', null: false
      t.text :pre
      t.text :post

      t.timestamps null: false
    end
  end
end
