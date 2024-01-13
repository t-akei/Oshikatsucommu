class Public::TagsearchesController < ApplicationController

  def search
    @model = Post
    @content = params[:content]
    @posts = Post.where('category LIKE ?', '%' + @content + '%')
    render 'tagsearches/tagform'
  end

end

