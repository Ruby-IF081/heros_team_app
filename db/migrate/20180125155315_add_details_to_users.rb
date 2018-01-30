class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table(:users) do |t|
      t.date :birthday
      t.string :avatar, :phone, :skills, :social_links
      t.text :education, :work, :about
    end
  end
end
