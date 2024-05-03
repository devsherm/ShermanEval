require "test_helper"

class AdminViewControllerTest < ActionDispatch::IntegrationTest
  test "should get admin_view" do
    get admin_view_admin_view_url
    assert_response :success
  end
end
