class AddJapaneseToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :japanese, :integer
  end
end
