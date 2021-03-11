class WatchedItemsController < ApplicationController
  before_action :authenticate_user!

  # GET /watched_items
  def index
    @watched_items = current_user.watched_items.order("created_at desc")
  end

  # POST /watched_items
  def create
    @watched_item = current_user.watched_items.build(watched_item_params)
    if !current_user.is_part_of_watchlist?(@watched_item.instrument_id) and @watched_item.save
      redirect_to instrument_url(@watched_item.instrument), notice: "Instrument was successfully added to watchlist."
    else
      redirect_to instrument_url(@watched_item.instrument), notice: "Could not add instrument to watchlist."
    end 
  end

  # DELETE /watched_items/1
  def destroy
    @watched_item = WatchedItem.find(params[:id])
    @instrument = @watched_item.instrument
    @watched_item.destroy
    redirect_to instrument_url(@instrument), notice: 'Instrument removed from watchlist.'
  end

  private 
  def watched_item_params
    params.require(:watched_item).permit(:user_id, :instrument_id)
  end
end