class PhotosController < ApplicationController

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new( image_params )
    if @photo.save
      redirect_to photos_path
    else
      render 'new'
    end
  end

  private

  def image_params
    params.require(:photo).permit(:image, :caption)
  end
end
