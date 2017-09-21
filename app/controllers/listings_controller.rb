class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /listings
  # GET /listings.json
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

  # GET /listings/1
  def show
    @listing = Listing.find(params[:id])
    @user = current_user
  end

  def verify
    @listing = Listing.find(params[:id])
    @user = current_user

    @listing.verified = true
    @listing.save
    redirect_to user_listing_path(@user, @listing)
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @user = current_user
  end

  # GET /listings/1/edit
  def edit
    @listing = Listing.find(params[:id])
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)

    if @listing.save
      redirect_to '/listings'
    else
      render template: "/listings/new"
    end

    # respond_to do |format|
    #   if @listing.save
    #     format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
    #     format.json { render :show, status: :created, location: @listing }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @listing.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    if @listing.update(listing_params)
      redirect_to '/listings'
    else
      render template: "/listings/edit"
    end
    # respond_to do |format|
    #   if @listing.update(listing_params)
    #     format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @listing }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @listing.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    redirect_to '/listings'
    # respond_to do |format|
    #   format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:user_id, :name, :place_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :address, :price, :description, :verified)
    end

end
