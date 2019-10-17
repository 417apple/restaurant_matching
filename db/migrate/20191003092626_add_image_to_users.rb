class AddImageToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :cl_image, :string
  end
end
