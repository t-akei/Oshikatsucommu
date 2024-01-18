# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # ユーザーステータスがアクティブであるかを判断するメソッド
  def user_state
    user = User.find_by(email: params[:user][:email])
    # 入力されたemailが合致するアカウントを1件取得
    return if user.nil?
    # アカウントを取得できなかった場合このメソッドを終了する
    return unless user.valid_password?(params[:user][:password])
    # 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
    unless user.is_active == true
      flash[:alert] = "ユーザーステータスが無効です"
      redirect_to new_user_registration_path
    end
    # もしユーザーステータスがtrueじゃない＝有効じゃないなら新規登録へ飛ぶ
  end


end
