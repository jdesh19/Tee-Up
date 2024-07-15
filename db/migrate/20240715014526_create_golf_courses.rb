class CreateGolfCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :golf_courses do |t|
      t.string :name
      t.integer :holes
      t.string :location

      t.timestamps
    end
  end
end
