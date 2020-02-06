class Chatroom < ApplicationRecord
  validates :name, presence: true
  
  enum genre: {
    '英語': 1,
    '外国': 2,
    '健康': 3,
    '趣味': 4,
    '本': 5,
    'アーティスト': 6,
    'イベント': 7,
    'お笑い': 8,
    'スポーツ': 9,
    'ビジネス': 10,
    'プログラミング': 11,
    'その他': 12
  }
  
  enum target: {
    '初心者': 1,
    'エキスパート': 2,
    '指定なし': 3
  }

  belongs_to :user #ルーム作成者
  has_many :user_chatrooms #ルーム入会者
  has_many :spoken_users, through: :user_chatrooms, source: :user, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :questions, dependent: :destroy
  
  
  def self.search(name,genre,target)
    if name.blank? && genre.blank? && target.blank?
      Chatroom.all.order(id: "DESC")
    elsif name.blank? && genre.blank?
      Chatroom.where('cast(target as text) LIKE ?', "#{target}").order(id: "DESC")
    elsif name.blank? && target.blank?
      # Chatroom.where('genre LIKE ?', "#{genre}").order(id: "DESC")
      Chatroom.where('cast(genre as text) LIKE ?', "#{genre}").order(id: "DESC")
    elsif genre.blank? && target.blank?
      Chatroom.where('name LIKE ?', "%#{name}%").order(id: "DESC")
    elsif target.blank?
      Chatroom.where('name LIKE ? and cast(genre as text) LIKE ?', "%#{name}%", "#{genre}").order(id: "DESC")
    elsif genre.blank?
      Chatroom.where('name LIKE ? and cast(target as text) LIKE ?', "%#{name}%", "#{target}").order(id: "DESC")
    elsif name.blank?
      Chatroom.where('cast(genre as text) LIKE ? and cast(target as text) LIKE ?', "#{genre}", "#{target}").order(id: "DESC")
    else
      Chatroom.where('name LIKE ? and cast(genre as text) LIKE ? and cast(target as text) LIKE ?' , "%#{name}%", "#{genre}", "#{target}").order(id: "DESC")
    end
  end
end

# .where('cast(genre1 as text) LIKE ?', "%#{params[:genre1]}%").where('genre2 LIKE ?', "%#{params[:genre2]}%"