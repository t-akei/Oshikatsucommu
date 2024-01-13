class Post < ApplicationRecord

  belongs_to :user
  has_one_attached :post_image

  # validates :genre_id, presence: true
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 250 }
  # validates :category, presence: true

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content, body: content)
    elsif method == 'forward'
      Post.where('title LIKE ? OR body LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('title LIKE ? OR body LIKE ?', '%' + content)
    else method == 'partial'
      Post.where('title LIKE ? OR body LIKE ?', '%' + content + '%')
    end
  end

end
