class AddTenantIdToVisit < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :tenant_id, :integer
  end
end
