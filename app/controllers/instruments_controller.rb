class InstrumentsController < ApplicationController
  before_action :set_instrument, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :is_closed?, only: [:edit, :update]
  after_action :create_winning_bid, only: [ :update ]
  after_action :create_bid, only: [ :create ]

  # GET /instruments
  # GET /instruments.json
  def index
    @instruments = Instrument.all.order("created_at desc")
  end

  # GET /instruments/1
  # GET /instruments/1.json
  def show
    @bid = Bid.new
    @watched_item = WatchedItem.new
    # p current_user.get_watched_item(@instrument.id)
    # p watched_item_path(current_user.get_watched_item(@instrument.id))
  end

  # GET /instruments/new
  def new
    @instrument = current_user.instruments.build
  end

  # GET /instruments/1/edit
  def edit
  end

  # POST /instruments
  # POST /instruments.json
  def create
    @instrument = current_user.instruments.build(instrument_params)
    @instrument.image.attach(params[:instrument][:image])
    respond_to do |format|
      if @instrument.save
        format.html { redirect_to @instrument, notice: 'Instrument was successfully created.' }
        format.json { render :show, status: :created, location: @instrument }
      else
        format.html { render :new }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instruments/1
  # PATCH/PUT /instruments/1.json
  def update
    respond_to do |format|
      if @instrument.update(instrument_params)
        format.html { redirect_to @instrument, notice: 'Instrument was successfully updated.' }
        format.json { render :show, status: :ok, location: @instrument }
      else
        format.html { render :edit }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instruments/1
  # DELETE /instruments/1.json
  def destroy
    begin
      @instrument.destroy
      respond_to do |format|
        format.html { redirect_to instruments_url, notice: 'Instrument was successfully destroyed.' }
        format.json { head :no_content }
      end
    rescue ActiveRecord::RecordNotDestroyed => error 
      puts "errors that prevented destruction: #{error.record.errors}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instrument
      @instrument = Instrument.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def instrument_params
      params.require(:instrument).permit(:brand, :model, :description, :condition, :finish, :title, :price, :image, :closed)
    end

    # Create a bid after a posting is created
    def create_bid
      @instrument.bids.create!(user: current_user, price: @instrument.price)
    end 

    def is_closed?
      if @instrument.closed
        redirect_to @instrument, alert: "You cannot edit a closed listing." 
      end
    end

    def create_winning_bid
      if instrument_params[:closed]
        winner = @instrument.bids.max.user
        WinningBid.create!(user: winner, instrument: @instrument)
      end 
    end
end
