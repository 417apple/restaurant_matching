class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :user
      # t.references :follow, foreign_key: { to_table: :users }
      t.integer :follow

      t.timestamps
    end
  end
end
