class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    bookmark = post.bookmarks.new(user_id: current_user.id)
    bookmark.save
    redirect_to request.referer
    #上２行の別の書き方↓
    # bookmark = Bookmark.new(user_id: current_user.id)
    # post = Post.find(params[:post_id])
    # bookmark.post_id = post.id
  end

  def index
    @bookmarks = Bookmark.where(user_id: current_user.id)
    @user = current_user
  end

  def destroy
    post = Post.find(params[:post_id])
    bookmark = post.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?
      bookmark.destroy
      redirect_to request.referer
    end
  end

end
