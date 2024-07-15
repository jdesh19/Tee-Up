class ChangeCourseToCourseIdInTeeTimes < ActiveRecord::Migration[7.1]
  def change
    change_table :tee_times do |t|
      t.remove :course
      t.integer :course_id, null: false
    end
  end
end
