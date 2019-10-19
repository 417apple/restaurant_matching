class AddReferencesToTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :entries, :user, index: true
    add_reference :likes, :user, index: true
    add_reference :messages, :user, index: true
  end
end
