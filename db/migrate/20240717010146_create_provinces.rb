class CreateProvinces < ActiveRecord::Migration[7.1]
  def change
    create_table :provinces do |t|
      t.string :province
      t.decimal :pst
      t.decimal :gst
      t.decimal :hst
      t.decimal :total_tax_rate

      t.timestamps
    end
  end
end
