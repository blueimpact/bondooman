class RemoveGenreAndSegmentFromItems < ActiveRecord::Migration
  def change
    remove_reference :items, :genre, index: true, foreign_key: true
    remove_reference :items, :segment, index: true, foreign_key: true
  end
end
