class DeleteUserChatroomIdUniqIndexFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_index :posts, column: [:user_id, :chatroom_id]
  end
end
