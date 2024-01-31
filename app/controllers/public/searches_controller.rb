class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @word = params[:word]
    @method = params[:method]
    @posts = Post.search_for(@word, @method).order(created_at: :desc).page(params[:page]).per(5)
    @user = current_user
    @genres = Genre.where.not(name: 'その他')
    @other_genre = Genre.find_by(name: 'その他')
  end

end
