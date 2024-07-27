class AddDetailsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :tee_time_id, :integer
    add_column :orders, :combined_accessory_id, :integer
    add_column :orders, :user_id, :integer
    add_column :orders, :total_price, :integer
    add_column :orders, :item_quantity, :integer
  end
end
