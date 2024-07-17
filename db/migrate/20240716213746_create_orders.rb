class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :shopping_cart_id

      t.timestamps
    end
    add_index :orders, :shopping_cart_id
    add_foreign_key :orders, :shopping_carts
  end
end
