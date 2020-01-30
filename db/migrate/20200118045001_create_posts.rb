class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :chatroom, foreign_key: true

      t.timestamps
      t.index [:user_id, :chatroom_id], unique: true #削除済
    end
  end
end
