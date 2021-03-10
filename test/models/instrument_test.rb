require "test_helper"

class InstrumentTest < ActiveSupport::TestCase
  def setup
    @instrument = instruments(:one)
  end

  test "should get max bid" do
    # Should return max bid of 10
    assert_equal 10, @instrument.max_bid

    # New bid should make the max bid now 20
    @instrument.bids.create(price: 20, user: @instrument.user)
    assert_equal 20, @instrument.max_bid
  end
end
