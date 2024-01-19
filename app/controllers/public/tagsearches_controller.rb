class Public::TagsearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @content = params[:content]
    @posts = Post.where('category LIKE ?', '%' + @content + '%')
    @user = current_user
  end

end

