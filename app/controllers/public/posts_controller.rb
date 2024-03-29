class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:edit, :update]

  def new
    @post = Post.new
    @user = current_user
    @genres = Genre.where.not(name: 'その他')
    @other_genre = Genre.find_by(name: 'その他')
  end

  def create
    @post = Post.new(post_params)
    @genres = Genre.where.not(name: 'その他')
    @other_genre = Genre.find_by(name: 'その他')
    @user = current_user
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "You have created post successfully"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.order(created_at: :desc)
    @genres = Genre.where.not(name: 'その他')
    @other_genre = Genre.find_by(name: 'その他')
  end

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(5)
    @user = current_user
    @genres = Genre.where.not(name: 'その他')
    @other_genre = Genre.find_by(name: 'その他')
  end

  def edit
    @post = Post.find(params[:id])
    @user = current_user
    @genres = Genre.where.not(name: 'その他')
    @other_genre = Genre.find_by(name: 'その他')
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
    params.require(:post).permit(:profile_image, :title, :body, :post_image, :category, :genre_id)
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    user = post.user_id
    unless user == current_user.id
      redirect_to user_path(user)
    end
  end

end