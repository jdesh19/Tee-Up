class AddUserProvinceToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :user_province, :string
  end
end
