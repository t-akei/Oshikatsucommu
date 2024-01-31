class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(7)
    @genres = Genre.where.not(name: 'その他')
    @other_genre = Genre.find_by(name: 'その他')
  end

  def edit
    @user = User.find(params[:id])
    @genres = Genre.where.not(name: 'その他')
    @other_genre = Genre.find_by(name: 'その他')
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      flash[:alert] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to user_path(current_user)
    end
  end

end
