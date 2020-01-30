class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum:50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  
  # チャットルームの入室履歴・削除
  has_many :chatrooms #作成したルーム
  
  has_many :user_chatrooms #入っているルーム
  has_many :chatting_rooms, through: :user_chatrooms, source: :chatroom
  has_many :posts
  
  def join(chatroom)
    self.user_chatrooms.find_or_create_by(chatroom_id: chatroom.id)
  end
  
  def unjoin(chatroom)
    chatroom = self.user_chatrooms.find_by(chatroom_id: chatroom.id)
    chatroom.destroy if chatroom
  end
  
  def joining?(chatroom)
    self.chatting_rooms.include?(chatroom)
  end
  
  has_many :questions
end