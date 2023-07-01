class User < ApplicationRecord
  has_many :books
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :book_images, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  
  #フォローしている
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #フォローされてる
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #フォローしている人(全体)
  has_many :follower_users, through: :followed, source: :follower
  #フォローされている人（全体）
  has_many :following_users, through: :follower, source: :followed
  
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
   validates :introduction, length: { maximum: 50 }
   
   # followメソッド　＝　フォローする
  def follow(user_id)
   follower.create(followed_id: user_id)
  end

  # unfollowメソッド　＝　フォローを外す
  def unfollow(user_id)
   follower.find_by(followed_id: user_id).destroy
  end

  # followingメソッド　＝　既にフォローしているかの確認
  def following?(user)
   following_users.include?(user)
  end

# 検索方法分岐 (nameは検索対象であるusersテーブル内のカラム名)
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  
  def get_profile_image(width, height)
      unless profile_image.attached?
         file_path = Rails.root.join('app/assets/images/no_image.jpg')
         profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
