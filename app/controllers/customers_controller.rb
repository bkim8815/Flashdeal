class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]


  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    coupon_id = params[:customer][:coupon_id]

    c = Coupon.find(coupon_id)
    @r = Restaurant.find(c.restaurant_id)

      @customer_phone = params[:customer][:phone_number]
     if Customer.find_by_phone_number(@customer_phone).nil?
       @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save

        Subscription.create(customer_id: @customer.id, restaurant_id: @r.id, status: true)

        send_sms(@customer.phone_number)

        format.html { redirect_to coupons_path, notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  else
    @current_customer = Customer.find_by_phone_number(@customer_phone)

    Subscription.create(customer_id: @current_customer.id, restaurant_id: @r.id, status: true)

    send_sms(@current_customer.phone_number)
    respond_to do |format|
    format.html { redirect_to coupons_path , notice: 'Subscription was successfully created.' }
  end
  end
end


  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end


  def incoming
    sender = params[:From]
    body = params[:Body]
    @subscription = Subscription.all

    twiml = Twilio::TwiML::Response.new do |r|
      @subscription.each do |subs|
        if (("+1"+(subs.customer.phone_number.to_s)) == sender) && (body.downcase == "unfollow #{(subs.restaurant.name).downcase}")
          r.Message "You are unsubscribed from #{subs.restaurant.name}."
          subs.destroy

        elsif ("+1"+(subs.customer.phone_number.to_s)) == sender && (body.downcase == "unfollow")
          r.Message "I don't know that command. Please type unfollow+businessname"

        else


        end
      end

    end
    render xml: twiml.text

  end



  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def send_sms(phone)
      # set up a client to talk to the Twilio REST API
     @client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']

     @client.account.messages.create({
      :from => '+19548585330',
      :to => '+1'+phone,
      :body => "Thank you for subscribing to #{@r.name}!! to unfollow text unfollow #{@r.name}",
     })
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:phone_number, :latitude, :longitude)
    end
end
