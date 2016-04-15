class AddLabelToFormatters < ActiveRecord::Migration
  def change
    add_column :formatters, :label, :string
  end
end
