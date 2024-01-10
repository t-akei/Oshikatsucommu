class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def index
    @posts = Post.all
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body)
    #:genre_id,を追加すること
  end


end
