class AddResponceStatusToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :response_status, :string
  end
end
