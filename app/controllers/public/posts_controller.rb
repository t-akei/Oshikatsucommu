class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
    @user = User.find(params[:id])
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      flash[:notice] = "You have created post successfully"
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    # if @user == current_user
    #   link_to "Edit", edit_post_path(@post)
    #   link_to "Destroy", post_path(@post), method: :delete, "data-confirm" => "投稿を削除しますか？"
    # end
  end

  def index
    @posts = Post.all
    @user = User.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @user = User.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      flash[:notice] = "You have updated post successfully"
      redirect_to post_path(post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(post.user_id)
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :post_image)
    #:genre_id,を追加すること
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(user.id)
    end
  end

end
