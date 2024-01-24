class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:index]

  def create
    @post = Post.find(params[:post_id])
    @bookmark = @post.bookmarks.new(user_id: current_user.id)
    @bookmark.save
    # redirect_to request.referer
    # JSファイルを探しに行ってもらうため

    #上２行の別の書き方↓
    # bookmark = Bookmark.new(user_id: current_user.id)
    # post = Post.find(params[:post_id])
    # bookmark.post_id = post.id
  end

  def index
    @bookmarks = Bookmark.where(user_id: current_user.id).order(created_at: :desc).page(params[:page])
    @user = current_user
    @genres = Genre.all
  end

  def destroy
    @post = Post.find(params[:post_id])
    @bookmark = @post.bookmarks.find_by(user_id: current_user.id)
    if @bookmark.present?
      @bookmark.destroy
      # redirect_to request.referer
    end
  end


  private

  def is_matching_login_user
    user = User.find(params[:user_id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
