require "test_helper"

class TeeTimesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tee_times_index_url
    assert_response :success
  end
end
