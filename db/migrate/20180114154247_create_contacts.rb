class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :message

      t.timestamps
    end
    add_index :contacts, :name
    add_index :contacts, :email
    add_index :contacts, :phone
  end
end
