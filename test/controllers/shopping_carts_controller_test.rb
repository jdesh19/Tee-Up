require "test_helper"

class ShoppingCartsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get shopping_carts_show_url
    assert_response :success
  end

  test "should get destroy" do
    get shopping_carts_destroy_url
    assert_response :success
  end
end
