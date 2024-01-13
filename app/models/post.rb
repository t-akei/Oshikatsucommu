class Post < ApplicationRecord

  belongs_to :user
  has_one_attached :post_image

  validates :genre_id, presence: true
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 250 }

end
