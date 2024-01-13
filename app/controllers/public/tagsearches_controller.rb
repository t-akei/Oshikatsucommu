class Public::TagsearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    # @model = Post
    @content = params[:content]
    @posts = Post.where('category LIKE ?', '%' + @content + '%')
    # render 'tagsearches/tagform'
  end

end

