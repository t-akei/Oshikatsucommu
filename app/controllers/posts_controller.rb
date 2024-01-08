class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new
    @post.user_id = current_user.id
    @post.save
    # redirect_to 一覧ページ
  end

  def show
  end

  def index
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  
end
