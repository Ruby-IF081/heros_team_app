class RemoveTenantRefFromCompanies < ActiveRecord::Migration[5.1]
  def change
    remove_reference :companies, :tenant, foreign_key: true
  end
end
