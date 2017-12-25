class AddCompanyRefToPages < ActiveRecord::Migration[5.1]
  def change
    add_reference :pages, :company, foreign_key: true
  end
end
