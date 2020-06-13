class Tweet < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :body, presence: :true, length: {maximum: 140}
  validates :user_id, presence: true

  attachment :image

  default_scope -> { order(created_at: :desc) } #ここに記述することでtweetモデルでの投稿全て影響する

  def favorited_by?(user)
  	favorites.where(user_id: user.id).exists?
  end
end
