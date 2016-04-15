class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :formatter, index: true, foreign_key: true
      t.references :ranking_fetcher, index: true
      t.references :item_fetcher, index: true

      t.timestamps null: false
    end

    add_foreign_key :subscriptions, :fetchers, column: :ranking_fetcher_id
    add_foreign_key :subscriptions, :fetchers, column: :item_fetcher_id
  end
end
