class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def create
    @genre = Genre.new(genre_params)
    @genres = Genre.all
    if @genre.save
      redirect_to admin_genres_path
    else
      redirect_to admin_genres_path
      # render :index
    end
  end

  def index
    @genre = Genre.new
    @genres = Genre.all.order(created_at: :desc).page(params[:page]).per(7)
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end


end
