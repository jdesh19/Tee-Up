class RemoveQuantityFromAccessory < ActiveRecord::Migration[7.1]
  def change
    remove_column :accessories, :quantity, :integer
  end
end
