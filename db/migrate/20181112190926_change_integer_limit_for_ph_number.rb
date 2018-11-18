class ChangeIntegerLimitForPhNumber < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :phone_no, :integer, limit: 8
  end
end
