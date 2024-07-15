class CreateAccessories < ActiveRecord::Migration[7.1]
  def change
    create_table :accessories do |t|
      t.string :product
      t.integer :price
      t.integer :quantity
      t.references :shopping_cart, null: false, foreign_key: true

      t.timestamps
    end
  end
end
