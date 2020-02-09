class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum:50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  
  has_many :chatrooms, dependent: :destroy #作成したルーム
  
  has_many :user_chatrooms, dependent: :destroy #お気に入りルーム
  has_many :favoritings, through: :user_chatrooms, source: :chatroom, dependent: :destroy
  
  
  has_many :posts, dependent: :destroy

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  
  def favorite(chatroom)
    self.user_chatrooms.find_or_create_by(chatroom_id: chatroom.id)
  end
  
  def unfavorite(chatroom)
    chatroom = self.user_chatrooms.find_by(chatroom_id: chatroom.id)
    chatroom.destroy if chatroom
  end
  
  def favoriting?(chatroom)
    self.favoritings.include?(chatroom)
  end
end