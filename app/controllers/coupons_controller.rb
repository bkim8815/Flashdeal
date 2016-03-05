class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]
  before_action :set_restaurant, only: [:new, :create]
  before_action :getlatlong, only: [:index]
  before_action :require_logged_in, only: [:new, :create, :update, :destroy, :only]

  # GET /coupons
  # GET /coupons.json
  def index

    @coupons = Coupon.all
    @somethingelse = []
    @coupons.each do |coupon|
      if (coupon.restaurant.latitude < (@lat.to_f + 10)) && (coupon.restaurant.latitude > (@lat.to_f - 10))
        if (coupon.restaurant.longitude < (@long.to_f + 10)) && (coupon.restaurant.longitude > (@long.to_f - 10))


        end
          @somethingelse << coupon

      end

    end


    @map_hash=Gmaps4rails.build_markers(@somethingelse) do |coupon, marker|
      if coupon.expiration == true

      else
        marker.lat coupon.restaurant.latitude
        marker.lng coupon.restaurant.longitude
        marker.infowindow coupon.price
      end

    end

  end



  # GET /coupons/1
  # GET /coupons/1.json
  def show
    @phone = Phone.new
    @phone.mobile = params[:phone_number]
  end

  # GET /coupons/new
  def new
    @coupon = current_restaurant.coupons.new
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
        @subscriptions = Subscription.all

        @subscriptions.each do |subs|
        if subs.restaurant_id == @coupon.restaurant_id
        @client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']

        @client.account.messages.create({
         :from => '+19548585330',
         :to => '+1'+subs.customer.phone_number,
         :body => "#{@restaurant.name} has a new offer for you, click #{ coupon_url(@coupon.id, phone_number: subs.customer.phone_number  ) } to claim it!"
        })
      end
    end
        format.html { redirect_to only_path(@restaurant), notice: 'Coupon was successfully created.' }
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
      format.html { redirect_to only_path(@current_restaurant), notice: 'Coupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  def only
    @coupons = (Coupon.where(restaurant_id: params[:restaurant_id], expiration: false))
    



  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:title, :price, :start_time, :end_time, :expiration, :max_count, :restaurant_id, :picture, :promocode)
    end
    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end


  def getlatlong
    @lat =params[:lat]
    @long =params[:long]




  end
end
