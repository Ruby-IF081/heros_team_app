class AddTokenCreatedAtToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :auth_token, :string
    add_column :users, :token_created_at, :datetime
    add_index :users, %i[auth_token token_created_at]
  end
end
