class AddShoppingCartIdToCombinedAccessories < ActiveRecord::Migration[7.1]
  def change
    add_column :combined_accessories, :shopping_cart_id, :integer
  end
end
