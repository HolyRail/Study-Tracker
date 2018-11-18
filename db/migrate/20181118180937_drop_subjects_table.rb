class DropSubjectsTable < ActiveRecord::Migration[5.2]
  def change
    change_table :subjects do |t|
      t.belongs_to :user, index: true
    end
  end
end
