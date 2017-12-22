class StatusToPages < ActiveRecord::Migration[5.1]
  def change
    change_column :pages, :status, :string
    change_column :pages, :page_type, :string
  end
end
