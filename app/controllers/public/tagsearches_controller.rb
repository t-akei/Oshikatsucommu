class Public::TagsearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @content = params[:content]
    @posts = Post.where('category LIKE ?', '%' + @content + '%')
  end

end

