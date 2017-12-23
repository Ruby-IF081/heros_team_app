class AddOwnerIdToTenants < ActiveRecord::Migration[5.1]
  def change
    add_column :tenants, :owner_id, :integer
    add_index  :tenants, :owner_id
  end
end
