class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    # @model = params[:post]
    @word = params[:word]
    @method = params[:method]
    @results = Post.search_for(@word, @method)
  end

end
