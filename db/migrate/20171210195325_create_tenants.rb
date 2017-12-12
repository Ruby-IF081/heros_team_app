class CreateTenants < ActiveRecord::Migration[5.1]
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :phone
      t.string :website
      t.string :logo

      t.timestamps
    end
  end
end
