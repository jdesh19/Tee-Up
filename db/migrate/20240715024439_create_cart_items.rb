class CreateCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items do |t|
      t.references :shopping_cart, null: false, foreign_key: true
      t.references :tee_time, null: false, foreign_key: true
      t.references :accessory, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
