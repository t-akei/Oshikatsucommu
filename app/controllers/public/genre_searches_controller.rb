class Public::GenreSearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @genre = Genre.find(params[:genre_id])
    @posts = Post.where(genre_id: @genre.id).order(created_at: :desc).page(params[:page]).per(5)
    # 投稿の内、genre_idに指定されたジャンルのIDを持つ投稿を全て取得
    @user = current_user
    @genres = Genre.all
  end

end
