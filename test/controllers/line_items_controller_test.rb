require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post line_items_url, params: { line_item: { cart_id: @line_item.cart_id, 
                                                  instrument: @line_item.instrument }, 
                                    instrument_id: @line_item.instrument_id }
    end

    assert_redirected_to cart_url(LineItem.last.cart_id)
  end

  test "should update line_item" do
    patch line_item_url(@line_item), params: { line_item: { cart_id: @line_item.cart_id, instrument: @line_item.instrument } }
    assert_redirected_to line_item_url(@line_item)
  end
end
