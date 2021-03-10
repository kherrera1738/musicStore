class LineItem < ApplicationRecord
  belongs_to :instrument
  belongs_to :cart

  def total_price
    instrument.max_bid.to_i * quantity.to_i
  end
end
