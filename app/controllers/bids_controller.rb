class BidsController < ApplicationController
  before_action :authenticate_user!
 
  # POST /bids 
  def create
    @instrument = Instrument.find_by(id: params[:id])
    max_bid = @instrument.max_bid
    @bid = @instrument.bids.build(bid_params)

    if @bid.price > max_bid and @bid.save
      redirect_to instrument_path(@instrument), notice: "Bid added successfully."
    else
      redirect_to instrument_path(@instrument), notice: "Bid unable to be added. Make sure the bid is higher than the current price"
    end
  end

  private

    def bid_params
      params.require(:bid).permit(:price, :user_id, :instrument_id)
    end

end