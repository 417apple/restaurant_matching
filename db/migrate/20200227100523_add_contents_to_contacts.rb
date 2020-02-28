class AddContentsToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :contents, :string
  end
end
