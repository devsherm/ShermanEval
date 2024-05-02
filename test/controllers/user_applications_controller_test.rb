require "test_helper"

class UserApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_application = user_applications(:one)
  end

  test "should get index" do
    sign_in @user_application.user
    get user_applications_url
    assert_response :success

    assert_select '.user-application', count: UserApplication.where(user: @user_application.user).count
  end

  test "should be able to view all applications as admin" do
    sign_in users(:admin)
    get user_applications_url
    assert_response :success

    assert_select '.user-application', count: UserApplication.count
  end

  test "should be able to filter applications by score as admin" do
    sign_in users(:admin)
    get user_applications_url(score: "pass")
    assert_response :success

    assert_select '.user-application', count: UserApplication.pass.count
  end

  test "should not be able to filter applications if not admin" do
    sign_in users(:one)
    get user_applications_url(score: "pass")
    assert_response :success

    assert_select '.user-application', count: UserApplication.where(user: users(:one)).count
  end

  test "should get new" do
    sign_in users(:two)
    get new_user_application_url
    assert_response :success
  end

  test "should get redirected from new if not signed in" do
    get new_user_application_url
    assert_response :redirect
  end

  test "should create user_application" do
    sign_in users(:one)
    assert_difference("UserApplication.count") do
      post user_applications_url, params: { user_application: { about_me: @user_application.about_me, first_name: @user_application.first_name, gender: @user_application.gender, last_name: @user_application.last_name, score: @user_application.score, skills: @user_application.skills, user_id: @user_application.user_id } }
    end

    assert_redirected_to user_application_url(UserApplication.last)
  end

  test "should redirect user on create if not signed in" do
    post user_applications_url, params: { user_application: { about_me: @user_application.about_me, first_name: @user_application.first_name, gender: @user_application.gender, last_name: @user_application.last_name, score: @user_application.score, skills: @user_application.skills, user_id: @user_application.user_id } }
    assert_response :redirect
  end

  test "should show user_application" do
    sign_in users(:one)
    get user_application_url(@user_application)
    assert_response :success
  end

  test "should show user_application when signed in as admin" do
    sign_in users(:admin)
    get user_application_url(@user_application)
    assert_response :success
  end

  test "should throw pundit error from show when signed in as other user" do
    sign_in users(:two)
    assert_raises(Pundit::NotAuthorizedError) do
      get user_application_url(@user_application)
    end
  end

  test "should get edit" do
    sign_in users(:admin)
    get edit_user_application_url(@user_application)
    assert_response :success
  end

  test "should throw pundit error from edit if not admin" do
    sign_in users(:one)
    assert_raises(Pundit::NotAuthorizedError) do
      get edit_user_application_url(@user_application)
    end
  end

  test "should update user_application" do
    sign_in users(:admin)
    patch user_application_url(@user_application), params: { user_application: { about_me: @user_application.about_me, first_name: @user_application.first_name, gender: @user_application.gender, last_name: @user_application.last_name, score: @user_application.score, skills: @user_application.skills, user_id: @user_application.user_id } }
    assert_redirected_to user_application_url(@user_application)
  end

  test "should throw pundit error from update if not admin" do
    sign_in users(:one)
    assert_raises(Pundit::NotAuthorizedError) do
      patch user_application_url(@user_application), params: { user_application: { about_me: @user_application.about_me, first_name: @user_application.first_name, gender: @user_application.gender, last_name: @user_application.last_name, score: @user_application.score, skills: @user_application.skills, user_id: @user_application.user_id } }
    end
  end

  test "should destroy user_application" do
    sign_in users(:admin)
    assert_difference("UserApplication.count", -1) do
      delete user_application_url(@user_application)
    end

    assert_redirected_to user_applications_url
  end

  test "should throw pundit error from destroy if not admin" do
    sign_in users(:one)
    
    assert_raises(Pundit::NotAuthorizedError) do
      delete user_application_url(@user_application)
    end
  end
end
