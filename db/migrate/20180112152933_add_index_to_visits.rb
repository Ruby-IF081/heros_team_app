class AddIndexToVisits < ActiveRecord::Migration[5.1]
  def change
    add_index :visits, :tenant_id
  end
end
