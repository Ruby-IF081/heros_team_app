class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string  :name
      t.string  :domain
      t.string  :youtube
      t.string  :twitter
      t.string  :linkedincompany
      t.string  :facebook
      t.string  :angellist
      t.string  :owler
      t.string  :crunchbasecompany
      t.string  :pinterest
      t.string  :google
      t.string  :klout
      t.string  :overview
      t.integer :founded
      t.integer :approx_employees

      t.timestamps
    end
  end
end
