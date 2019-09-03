class AddDueDateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :due_date, :date
    change_column_null :tasks, :due_date, false
  end
end
