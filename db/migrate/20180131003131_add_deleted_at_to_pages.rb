class AddDeletedAtToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :deleted_at, :datetime
    add_index :pages, :deleted_at
  end
end
