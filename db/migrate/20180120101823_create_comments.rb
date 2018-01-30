class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string  :commentable_type
      t.integer :commentable_id
      t.integer :user_id
      t.text    :body

      t.references :commentable, polymorphic: true
      t.belongs_to :user
      t.belongs_to :tenant

      t.timestamps
    end
  end
end
