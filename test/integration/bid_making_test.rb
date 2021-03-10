require "test_helper"

class BidMakingTest < ActionDispatch::IntegrationTest
  def setup
    @instrument = instruments(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should create instrument" do
    assert_difference('Bid.count') do
      post instruments_url, params: { instrument: { brand: "Fender", 
                                                    condition: "New", 
                                                    description: "instrument", 
                                                    finish: "Black", 
                                                    model: "Model", 
                                                    price: 1000, 
                                                    title: "title" } }
    end
    bid = Bid.last
    assert_equal @user, bid.user
  end

  test "should create new bid" do
    assert_difference('Bid.count') do
      post create_bid_url(@instrument), params: { bid: { price: 20, user_id: @user.id } }
    end

    assert_redirected_to instrument_url(@instrument)
    follow_redirect!
    assert_equal "Bid added successfully.", flash[:notice]
  end

  test "should not allow unathenticated users to make bid" do 
    sign_out @user
    post create_bid_url(@instrument), params: { bid: { price: 20, user_id: @user.id } }

    assert_redirected_to new_user_session_path
  end

  test "should not add bid if it is lower than the max bid" do
    assert_no_difference('Bid.count') do
      post create_bid_url(@instrument), params: { bid: { price: 0, user_id: @user.id } }
    end

    assert_redirected_to instrument_url(@instrument)
    follow_redirect!
    assert_equal "Bid unable to be added. Make sure the bid is higher than the current price", flash[:notice]
  end

  test "should not add negative bids" do
    no_bids_instrument = @user.instruments.create(brand: "Fender", 
                                          condition: "New", 
                                          description: "instrument", 
                                          finish: "Black", 
                                          model: "Model", 
                                          price: 1000, 
                                          title: "title" )

    assert_no_difference('Bid.count') do
      post create_bid_url(no_bids_instrument), params: { bid: { price: -1, user_id: @user.id } }
    end

    assert_redirected_to instrument_url(no_bids_instrument)
    follow_redirect!
    assert_equal "Bid unable to be added. Make sure the bid is higher than the current price", flash[:notice]
  end

  test "should add bid if none exist" do
    no_bids_instrument = @user.instruments.create(brand: "Fender", 
                                          condition: "New", 
                                          description: "instrument", 
                                          finish: "Black", 
                                          model: "Model", 
                                          price: 10, 
                                          title: "title" )

    assert_difference('Bid.count') do
      post create_bid_url(no_bids_instrument), params: { bid: { price: 10.01, user_id: @user.id } }
    end

    assert_redirected_to instrument_url(no_bids_instrument)
    follow_redirect!
    assert_equal "Bid added successfully.", flash[:notice]
  end
end
