class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }
  #あるユーザーは、ある投稿に対して一意=ある投稿に対してブクマは1回
end
