class RemoveOldProvincesTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :provinces
  end
end
