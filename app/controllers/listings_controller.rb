class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  def index
    # @listings = Listing.all
    @user = current_user
    @listings = Listing.order('created_at DESC').page(params[:page]).per(15)
  end

  def all
    # @listings = Listing.all
    @user = current_user
    @listings = Listing.order('created_at DESC').page(params[:page]).per(15)
  end

  def show
    @listing = Listing.find(params[:id])
    @user = current_user
    @reservation = Reservation.new
  end

  def verify
    @listing = Listing.find(params[:id])
    @user = current_user

    @listing.verified = true
    @listing.save
    redirect_to user_listing_path(@user, @listing)
  end

  def new
    @listing = Listing.new
    @user = current_user
  end

  def edit
    @listing = Listing.find(params[:id])
    # @listing.photos.build
  end

  def create
    @listing = Listing.new(listing_params)

    if @listing.save
      redirect_to '/listings'
    else
      render template: "/listings/new"
    end
  end

  def update
    if @listing.update(listing_params)
      redirect_to '/listings'
    else
      render template: "/listings/edit"
    end
  end

  def destroy
    @listing.destroy
    redirect_to '/listings'
  end

  def destroy_image
    @listing = Listing.find(params[:id])

    remove_image_at_index(params[:photo_id].to_i)
    flash[:error] = "Failed at deleting image" unless @listing.save
    redirect_to '/listings'
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:user_id, :name, :place_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :address, :price, :description, :verified, {photos: []}, photos_attributes: [
      :id,
      :image,
      :_destroy
      ])
  end

  def remove_image_at_index(index)
    byebug
    remain_images = @listing.photos # copy the array
    deleted_image = remain_images.delete_at(index) # delete the target image
    deleted_image.try(:remove!) # delete image from S3
    @listing.photos = remain_images # re-assign back
  end

end
