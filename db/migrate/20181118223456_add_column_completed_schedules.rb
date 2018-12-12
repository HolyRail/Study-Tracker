class AddColumnCompletedSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules,:completed,:boolean
  end
end
