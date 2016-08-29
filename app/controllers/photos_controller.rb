class PhotosController < ApplicationController

  def index
    @photos = Photo.all

  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to photos_path
    else
      flash[:notice] = "Whoops... you forgot to upload an image!"
      render 'new'
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
end
