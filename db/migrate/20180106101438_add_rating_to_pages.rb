class AddRatingToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :rating, :integer, default: 0
  end
end
