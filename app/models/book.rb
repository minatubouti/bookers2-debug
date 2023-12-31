class Book < ApplicationRecord
  belongs_to :user
   has_many :book_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy
   has_many :favorited_users, through: :favorites, source: :user
   has_many :look_counts, dependent: :destroy

   
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  # validates :rating, inclusion: { in: [1, 2, 3, 4, 5] }, on: :create

  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # 検索方法分岐 (titleは検索対象であるbooksテーブル内のカラム名)
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
  
end
