class CreateCombinedAccessories < ActiveRecord::Migration[7.1]
  def change
    create_table :combined_accessories do |t|
      t.integer :accessory_id
      t.integer :price
      t.integer :quantity

      t.timestamps
    end
  end
end
