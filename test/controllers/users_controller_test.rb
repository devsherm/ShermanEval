require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_user_registration_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post user_registration_url, params: { user: { email: "user@test.com", password: "Password123", password_confirmation: "Password123" } }
    end

    assert_redirected_to root_url
  end

  test "should not create user with invalid password confirmation" do
    assert_no_difference('User.count') do
      post user_registration_url, params: { user: { email: "user@test.com", password: "Password123", password_confirmation: "Password321" } }
    end
  
    assert_response :unprocessable_entity
  end
end
