class SetupSchema < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string "email",:null => false
      t.integer "phone_no"
      t.string "provider"
      t.string "year"
      t.string "first_name" 
      t.string "last_name"
      t.string "uid"
    end  
    
    change_column :users, :phone_no, :integer, limit: 8
    
    create_table :subjects do |s|
      s.string "name",:null =>false
      s.date "start_date"
      s.date "end_date"
      s.integer "hours"
      s.references 'user'
    end
    
    create_table :schedules do |sch|
      sch.time "start_time"
      sch.time "end_time"
      sch.integer "day_of_week"
      sch.references 'subject'
    end
  end
end
