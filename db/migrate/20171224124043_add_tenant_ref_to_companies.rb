class AddTenantRefToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_reference :companies, :tenant, foreign_key: true
  end
end
