class AddTenantRefToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :tenant, foreign_key: true
  end
end
