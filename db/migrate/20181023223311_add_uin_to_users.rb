class AddUinToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :UIN, :string
  end
end
