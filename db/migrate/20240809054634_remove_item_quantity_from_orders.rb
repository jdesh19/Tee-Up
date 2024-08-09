class RemoveItemQuantityFromOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :item_quantity, :integer
  end
end
