class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table(:users) do |t|
      t.column :date_of_birth, :datetime
      t.string :avatar, :phone, :skils, :social_links
      t.text :education, :work, :about
    end
  end
end
