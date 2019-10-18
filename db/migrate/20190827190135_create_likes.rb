class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|

      t.references  :restaurant,  index: true, foreign_key: true
      t.references  :user, index: true, foreign_key: true


      t.integer :user_id
      t.integer :restaurant_id
      t.timestamps
    end
  end
end
