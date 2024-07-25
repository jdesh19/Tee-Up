class AddQstToProvince < ActiveRecord::Migration[7.1]
  def change
    add_column :provinces, :qst, :decimal
  end
end
