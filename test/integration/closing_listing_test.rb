require "test_helper"

class ClosingListingTest < ActionDispatch::IntegrationTest
  def setup
    @instrument = instruments(:three)
    @user = users(:one)
    @winner = users(:two)
    sign_in @user
  end

  test "should close listing" do
    assert_difference('WinningBid.count') do
      patch instrument_url(@instrument), params: { instrument: { closed: true } }
    end
    @instrument.reload

    winning_bid = WinningBid.last
    assert_equal @instrument, winning_bid.instrument
    assert_equal @winner, winning_bid.user
    assert_equal 2, @winner.winning_bids.length
    
    assert @instrument.closed
    assert_redirected_to instrument_url(@instrument)
    follow_redirect!

    assert_select "p", "This listing has been closed."

    get edit_instrument_url(@instrument)
    assert_redirected_to instrument_url(@instrument)
    follow_redirect!
    assert_equal "You cannot edit a closed listing.", flash[:alert]

    patch instrument_url(@instrument), params: { instrument: { title: "New Title" } }
    @instrument.reload
    assert_redirected_to instrument_url(@instrument)
    follow_redirect!
    assert_equal "MyString", @instrument.title
    assert_equal "You cannot edit a closed listing.", flash[:alert]
  end
end
