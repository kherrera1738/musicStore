require "test_helper"

class WatchedItemsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @instrument_on_list = instruments(:one)
    @instrument_not_on_list = instruments(:two)
    @watched_item = watched_items(:one)
    sign_in @user
  end

  test "should add item to watchlist" do
    assert_difference('WatchedItem.count') do
      post watched_items_url params: { watched_item: { user_id: @user.id,
                                                        instrument_id: @instrument_not_on_list.id } }
    end

    assert_redirected_to instrument_url(@instrument_not_on_list)
    assert_equal "Instrument was successfully added to watchlist.", flash[:notice]
  end

  test "should not add items on watchlist" do
    assert_no_difference('WatchedItem.count') do
      post watched_items_url params: { watched_item: { user_id: @user.id,
                                                        instrument_id: @instrument_on_list.id } }
    end

    assert_redirected_to instrument_url(@instrument_on_list)
    assert_equal "Could not add instrument to watchlist.", flash[:notice]
  end

  test "should remove item from watchlist" do
    assert_difference('WatchedItem.count', -1) do
      delete watched_item_url(@watched_item)
    end
    assert_redirected_to instrument_url(@instrument_on_list)
    assert_equal "Instrument removed from watchlist.", flash[:notice]
  end

  test "should return watched items" do
    get watched_items_url
    assert_response :success
  end
end