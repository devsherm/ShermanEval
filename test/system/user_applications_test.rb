require "application_system_test_case"

class UserApplicationsTest < ApplicationSystemTestCase
  setup do
    @user_application = user_applications(:one)
  end

  test "visiting the index" do
    visit user_applications_url
    assert_selector "h1", text: "User applications"
  end

  test "should create user application" do
    visit user_applications_url
    click_on "New user application"

    fill_in "About me", with: @user_application.about_me
    fill_in "First name", with: @user_application.first_name
    fill_in "Gender", with: @user_application.gender
    fill_in "Last name", with: @user_application.last_name
    fill_in "Score", with: @user_application.score
    fill_in "Skills", with: @user_application.skills
    fill_in "User", with: @user_application.user_id
    click_on "Create User application"

    assert_text "User application was successfully created"
    click_on "Back"
  end

  test "should update User application" do
    visit user_application_url(@user_application)
    click_on "Edit this user application", match: :first

    fill_in "About me", with: @user_application.about_me
    fill_in "First name", with: @user_application.first_name
    fill_in "Gender", with: @user_application.gender
    fill_in "Last name", with: @user_application.last_name
    fill_in "Score", with: @user_application.score
    fill_in "Skills", with: @user_application.skills
    fill_in "User", with: @user_application.user_id
    click_on "Update User application"

    assert_text "User application was successfully updated"
    click_on "Back"
  end

  test "should destroy User application" do
    visit user_application_url(@user_application)
    click_on "Destroy this user application", match: :first

    assert_text "User application was successfully destroyed"
  end
end
