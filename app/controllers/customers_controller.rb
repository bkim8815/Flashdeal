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

    r = Restaurant.find(c.restaurant_id)
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save

        Subscription.create(customer_id: @customer.id, restaurant_id: r.id, status: true)

        # set up a client to talk to the Twilio REST API
       @client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']

       @client.account.messages.create({
        :from => '+19548585330',
        :to => '+1'+@customer.phone_number,
        :body => "Thank you for subscribing to #{r.name}!! to unfollow text unfollow #{r.name}",
       })
        format.html { redirect_to root_path , notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
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
    @customers = Customer.all
    @subscription = Subscription.all


    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "You are unsubscribed."
    end

    twiml2 = Twilio::TwiML::Response.new do |r|
      r.Message 'text'
    end





    @subscription.each do |subs|
      if ("+1"+(subs.customer.phone_number.to_s)) == sender
        subs.destroy
        twiml.text
      end



    end


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




    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:phone_number, :latitude, :longitude)
    end
end
