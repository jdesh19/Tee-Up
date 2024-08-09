class AddOrderIdToCombinedAccessories < ActiveRecord::Migration[7.1]
  def change
    add_column :combined_accessories, :order_id, :integer
  end
end
