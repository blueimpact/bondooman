class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.references :subscription, index: true, foreign_key: true
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
