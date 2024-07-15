class RemoveCourseIdFromTeeTimes < ActiveRecord::Migration[7.1]
  def change
    remove_column :tee_times, :course_id, :integer
  end
end
