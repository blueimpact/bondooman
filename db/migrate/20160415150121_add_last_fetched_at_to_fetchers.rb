class AddLastFetchedAtToFetchers < ActiveRecord::Migration
  def change
    add_column :fetchers, :last_fetched_at, :datetime
  end
end
