class RemoveShoppingCartIdFromOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :shopping_cart_id, :integer
  end
end
