class AddLogoToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :logo, :string
  end
end
