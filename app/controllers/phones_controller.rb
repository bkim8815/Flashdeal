class PhonesController < ApplicationController
  before_action :set_phone, only: [:show, :edit, :update, :destroy]

  # GET /phones
  # GET /phones.json
  def index
    @phones = Phone.all
  end

  # GET /phones/1
  # GET /phones/1.json
  def show
  end

  # GET /phones/new
  def new
    # @phone = Phone.new
    # @promotion = Promotion.new
    # if @promotion.coupon_id == @coupon_id
    #   //couter
    # else


  end

  # GET /phones/1/edit
  def edit
  end

  # POST /phones
  # POST /phones.json
  def create

    coupon_id = params[:coupon_id]
    c = Coupon.find_by(coupon_id)



    @phone = Phone.new(phone_params)

    respond_to do |format|
      if @phone.save

        Promotion.create(phone_id: @phone.id, coupon_id: c.id)
        # set up a client to talk to the Twilio REST API
       @client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']

       @client.account.messages.create({
        :from => '+19548585330',
        :to => '+1'+@phone.mobile,
        :body => "Thank you! your coupon promo code is #{c.promocode}",
       })

       if c.max_count < 1
         c.expiration = true
         c.save
       else
         c.max_count = c.max_count - 1
         c.save
       end




        format.html { redirect_to @phone, notice: 'Phone was successfully created.' }
        format.json { render :show, status: :created, location: @phone }
      else
        format.html { render :new }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phones/1
  # PATCH/PUT /phones/1.json
  def update
    respond_to do |format|
      if @phone.update(phone_params)
        format.html { redirect_to @phone, notice: 'Phone was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone }
      else
        format.html { render :edit }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phones/1
  # DELETE /phones/1.json
  def destroy
    @phone.destroy
    respond_to do |format|
      format.html { redirect_to phones_url, notice: 'Phone was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone
      @phone = Phone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_params
      params.require(:phone).permit(:mobile)
    end
end
