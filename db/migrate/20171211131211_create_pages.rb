# Create new migration for pages table
class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.integer :page_type
      t.string :title
      t.string :content_html
      t.string :content
      t.string :source_url
      t.integer :status
      t.string :screenshot

      t.timestamps
    end
  end
end
