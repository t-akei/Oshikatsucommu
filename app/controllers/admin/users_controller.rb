class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
  end
  
  def index
    @users = User.all
  end

end
