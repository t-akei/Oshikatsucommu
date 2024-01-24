class Post < ApplicationRecord

  belongs_to :user
  has_one_attached :post_image
  has_many :bookmarks, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  belongs_to :genre

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 250 }
  validates :category, presence: true
  validates :genre_id, presence: true

  def self.search_for(word, method)
    if method == 'perfect'
      Post.where('title LIKE ? OR body LIKE ? OR category LIKE ? OR genre_id IN (SELECT id FROM genres WHERE name LIKE ?)', word, word, word, word)
    elsif method == 'forward'
      Post.where('title LIKE ? OR body LIKE ? OR category LIKE ? OR genre_id IN (SELECT id FROM genres WHERE name LIKE ?)', word + '%', word + '%', word + '%', word + '%')
    elsif method == 'backward'
      Post.where('title LIKE ? OR body LIKE ? OR category LIKE ? OR genre_id IN (SELECT id FROM genres WHERE name LIKE ?)', '%' + word, '%' + word, '%' + word, '%' + word)
    else method == 'partial'
      Post.where('title LIKE ? OR body LIKE ? OR category LIKE ? OR genre_id IN (SELECT id FROM genres WHERE name LIKE ?)', '%' + word + '%', '%' + word + '%', '%' + word + '%', '%' + word + '%')
    end
  end

  def get_post_image
    post_image.variant(resize_to_limit: [350, 200]).processed
  end

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user)
  end
#ブクマが既にされているか(bookmarked_by?)のメソッドを定義している

end
