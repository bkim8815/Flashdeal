class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]
  before_action :set_restaurant, only: [:new, :create]
  before_action :getlatlong, only: [:index]

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.all

    @map_hash=Gmaps4rails.build_markers(@coupons) do |coupon, marker|
      marker.lat coupon.restaurant.latitude
      marker.lng coupon.restaurant.longitude
      marker.infowindow coupon.restaurant.name
    end




  end



  # GET /coupons/1
  # GET /coupons/1.json
  def show
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  # POST /coupons.json
  def create
    # @coupon = Coupon.new(coupon_params)
    @coupon = @restaurant.coupons.new(coupon_params)

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to @coupon, notice: 'Coupon was successfully created.' }
        format.json { render :show, status: :created, location: @coupon }
      else
        format.html { render :new }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to @coupon, notice: 'Coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to coupons_url, notice: 'Coupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:title, :price, :start_time, :end_time, :expiration, :max_count, :Restaurant_id, :picture)
    end
    def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end


  def getlatlong
    @lat =params[:lat]
    @long =params[:long]
    # render json: { lat: @lat, lang: @long }
  end
end
