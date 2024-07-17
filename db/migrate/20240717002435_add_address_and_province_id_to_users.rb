class AddAddressAndProvinceIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :address, :string
    add_column :users, :province_id, :integer
  end
end
