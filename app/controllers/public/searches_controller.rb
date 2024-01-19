class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @word = params[:word]
    @method = params[:method]
    @posts = Post.search_for(@word, @method).order(created_at: :desc)
    @user = current_user
    @genres = Genre.all
  end

end
