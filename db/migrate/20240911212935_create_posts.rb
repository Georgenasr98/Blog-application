class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.text :tags, default: "", null: false

      t.timestamps
    end
  end
end
