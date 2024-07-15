class CreateTeeTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :tee_times do |t|
      t.string :course
      t.datetime :start_time
      t.integer :price
      t.references :golf_course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
