class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :address
      t.string :cl_image
      t.text :comment
      t.time :opening
      t.time :closing
      t.timestamps
    end
  end
end
