class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string  :title
      t.text    :embed_code
      t.integer :videoable_id
      t.string  :videoable_type
      t.timestamps
    end
  end
end
