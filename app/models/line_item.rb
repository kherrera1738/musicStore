class LineItem < ApplicationRecord
  belongs_to :instrument
  belongs_to :cart

  def total_price
    (instrument.max_bid * 100 ).to_i / 100.0 * quantity.to_i
  end
end
