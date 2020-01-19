class CreateUserChatrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :user_chatrooms do |t|
      t.references :user, foreign_key: true
      t.references :chatroom, foreign_key: true

      t.timestamps
      t.index [:user_id, :chatroom_id], unique: true
    end
  end
end
