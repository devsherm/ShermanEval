require 'test_helper'

class UserApplicationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = create_user('applicant1@test.com')
    @user2 = create_user('applicant2@test.com')
    @employer = create_user('employer@test.com', admin: true)
    @user1_application = create_user_application(@user1, @employer, fav_hobby: 'reading')
    @user2_application = create_user_application(@user2, @employer, fav_hobby: 'writing')
  end

  teardown do
    User.destroy_all
  end

  # Index
  test 'when signed in as user should get index with only own applications' do
    sign_in @user1
    get user_applications_url
    assert_response :success
    assert_includes @response.body, 'reading'
    refute_includes @response.body, 'writing'
    assert_includes @response.body, 'Edit This Application'
  end

  test 'when signed in as admin should get index with all applications' do
    sign_in @employer
    get user_applications_url
    assert_response :success
    assert_includes @response.body, 'applicant1@test.com'
    assert_includes @response.body, 'applicant2@test.com'
    assert_includes @response.body, 'Evaluate This Application'
  end

  # New
  test 'should get new' do
    sign_in @user1
    get new_user_application_url
    assert_response :success
  end

  # Create
  test 'should create user_application when given valid params' do
    sign_in @user1

    assert_difference('UserApplication.count') do
      post user_applications_url, params: { user_application: {
        employer: @employer,
        my_level: :beginner,
        scratch_before: 'yes',
        fav_hobby: 'reading'
      } }
    end

    assert_redirected_to user_applications_url
  end

  test 'user cannot set eval' do
    sign_in @user1

    assert_difference('UserApplication.count') do
      post user_applications_url, params: default_params.merge(eval: :good_effort)
    end

    assert UserApplication.last.eval.nil?
  end

  test 'should render errors when given invalid params' do
    sign_in @user1

    post user_applications_url, params: { user_application: {
      invaid: 'param'
    } }

    assert_response :unprocessable_entity
  end

  # Edit
  test 'user edit cannot see eval' do
    @user1_application.update(eval: :good_effort)

    sign_in @user1
    get edit_user_application_url(@user1_application)
    assert_response :success
    refute_includes @response.body, 'Good Effort'
  end

  test 'admin edit can see eval' do
    @user1_application.update(eval: :good_effort)

    sign_in @employer
    get edit_user_application_url(@user1_application)
    assert_response :success
    assert_includes @response.body, 'Good effort'
  end

  test 'can update own application' do
    sign_in @user1
    patch user_application_url(@user1_application), params: edit_params
    assert_redirected_to user_applications_url
    @user1_application.reload
    assert_equal 'testing', @user1_application.reload.fav_hobby
  end

  test 'cannot update other user application' do
    sign_in @user1
    patch user_application_url(@user2_application), params: edit_params
    assert_redirected_to root_url
    refute_equal 'testing', @user2_application.reload.fav_hobby
  end

  test 'admin can only update evals on user applications' do
    sign_in @employer

    params = edit_params
    params[:user_application] = params[:user_application].merge(eval: :good_effort)

    patch(user_application_url(@user1_application), params:)
    assert_redirected_to user_applications_url
    refute_equal 'testing', @user1_application.reload.fav_hobby
    assert_equal 'good_effort', @user1_application.reload.eval
  end

  test 'user can destroy own application' do
    sign_in @user1
    assert_difference('UserApplication.count', -1) do
      delete user_application_url(@user1_application)
    end

    assert_redirected_to user_applications_url
  end

  test 'admin can destroy application' do
    sign_in @employer
    assert_difference('UserApplication.count', -1) do
      delete user_application_url(@user1_application)
    end
    assert_redirected_to user_applications_url
  end

  def default_params
    { user_application: { my_level: :beginner, scratch_before: 'yes', fav_hobby: 'reading' } }
  end

  def edit_params
    { user_application: { my_level: :intermediate, scratch_before: 'no', fav_hobby: 'testing' } }
  end
end
