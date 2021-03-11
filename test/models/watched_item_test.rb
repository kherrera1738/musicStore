require "test_helper"

class WatchedItemTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @watched_item = watched_items(:one)
    @instrument_on_list = instruments(:one)
    @instrument_not_on_list = instruments(:two)
  end

  test "should determine if instrument is on watchlist" do
    assert @user.is_part_of_watchlist?(@instrument_on_list.id)
    assert_not @user.is_part_of_watchlist?(@instrument_not_on_list.id)
  end

  test "should get correct bid" do
    assert @watched_item, @user.get_watched_item(@instrument_on_list.id)
  end
end
