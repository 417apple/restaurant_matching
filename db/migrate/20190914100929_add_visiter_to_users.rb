class AddVisiterToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :visiter, :integer
  end
end
