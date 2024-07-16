class RemoveShoppingCartIdFromAccessories < ActiveRecord::Migration[7.1]
  def change
    remove_column :accessories, :shopping_cart_id, :integer
  end
end
