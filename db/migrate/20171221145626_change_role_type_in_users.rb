class ChangeRoleTypeInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :role, :string, default: :admin
  end
end
