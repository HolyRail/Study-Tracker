class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string "email",:null => false
      t.integer "UIN" ,:null =>false
      t.integer "phone_no"
      t.string "year"
      t.string "first_name" 
      t.string "last_name"
    end
    
    create_table :subjects do |s|
      s.string "name",:null =>false
      s.date "start_date"
      s.date "end_date"
    end
    
    add_reference :subjects, :users, foreign_key: true
    
    create_table :schedules do |d|
      d.integer "hours"
      d.integer "day_of_week"
    end
    
    add_reference :schedules, :subjects, foreign_key: true
  end
end
