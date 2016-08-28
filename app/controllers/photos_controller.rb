class PhotosController < ApplicationController

  def index
    @photos = Photo.all
  end

  def new
    @photos = Photo.new
  end

  def create
    @photos = Photo.new(photo_params)
    if @photos.save
      redirect_to photos_path
    else
      render 'new'
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
end
