class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:post]
    @content = params[:content]
    @method = params[:method]
    @results = Post.search_for(@content, @method)
  end

end
