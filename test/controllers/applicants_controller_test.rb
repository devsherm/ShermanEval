require "test_helper"

class ApplicantsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get applicants_index_url
    assert_response :success
  end
end
