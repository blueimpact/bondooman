class AddCreatedOnToRankings < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        add_column :rankings, :created_on, :date
        Ranking.find_each do |ranking|
          ranking.update_columns created_on: ranking.created_at.to_date
        end
        change_column :rankings, :created_on, :date, null: false
      end

      dir.down do
        remove_column :rankings, :created_on
      end
    end
  end
end
