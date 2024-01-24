class Public::TagsearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @content = params[:content]
    @posts = Post.where('category LIKE ?', '%' + @content + '%').order(created_at: :desc).page(params[:page]).per(5)
    @user = current_user
    @genres = Genre.all
  end

end

