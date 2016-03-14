class AddRankingToShot < ActiveRecord::Migration
  def change
    add_reference :shots, :ranking, index: true, foreign_key: true
  end
end
