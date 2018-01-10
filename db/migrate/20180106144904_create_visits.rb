class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.integer :user_id

      t.timestamps
    end
    add_index :visits, :user_id
  end
end
