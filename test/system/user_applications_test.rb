require 'application_system_test_case'

class UserApplicationsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = create_user('applicant1@test.com')
    @employer = create_user('employer@test.com', admin: true)
    @user1_application = create_user_application(@user1, @employer, fav_hobby: 'reading')

    sign_in @user1
  end

  test 'should create user application' do
    visit user_applications_url
    click_on 'New Application'

    fill_in 'Fav hobby', with: 'test'
    choose 'Intermediate'

    click_on 'Submit Application'

    assert_text 'Application was successfully created'
  end

  test 'should update User application' do
    visit user_applications_url

    click_on 'Edit This Application', match: :first

    fill_in 'Fav hobby', with: 'test'
    choose 'Intermediate'

    click_on 'Submit Application'

    assert_text 'Application was successfully updated'
    assert_equal UserApplication.last.fav_hobby, 'test'
  end

  test 'should destroy User application' do
    visit user_applications_url
    find_button('Delete This Application', match: :first).click

    assert_text 'Application was successfully destroyed'
    assert UserApplication.count.zero?
  end
end
