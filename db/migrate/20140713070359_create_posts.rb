class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.text :body
      t.attachment :image

      t.timestamps
    end
  end
end
