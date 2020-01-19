class Chatroom < ApplicationRecord
  validates :name, presence: true
  
  enum genre: {
    '英語': 1,
    '音楽': 2,
    '趣味': 3,
    'スポーツ': 4,
    'ビジネス': 5,
    'その他': 6
  }
  
  enum target: {
    '初心者': 1,
    'エキスパート': 2,
    '指定なし': 3
  }

  belongs_to :user #ルーム作成者
  has_many :user_chatrooms #ルーム入会者
  has_many :spoken_users, through: :user_chatrooms, source: :user
  has_many :posts
  
end
