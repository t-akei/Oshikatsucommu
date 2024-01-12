class Public::UsersController < ApplicationController
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
    # @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "You have updated user successfully"
      redirect_to user_path(user)
    end
  end


  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  # end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
