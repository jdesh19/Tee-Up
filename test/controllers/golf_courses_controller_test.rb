require "test_helper"

class GolfCoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get golf_courses_index_url
    assert_response :success
  end
end
