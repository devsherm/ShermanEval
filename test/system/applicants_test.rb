require "application_system_test_case"

class ApplicantsTest < ApplicationSystemTestCase
  setup do
    @applicant = applicants(:one)
  end

  test "visiting the index" do
    visit applicants_url
    assert_selector "h1", text: "Applicants"
  end

  test "should create applicant" do
    visit applicants_url
    click_on "New applicant"

    check "Hybrid option" if @applicant.hybrid_option
    fill_in "Perks", with: @applicant.perks
    fill_in "Rails level", with: @applicant.rails_level
    fill_in "Salary", with: @applicant.salary
    fill_in "Test score", with: @applicant.test_score
    fill_in "User", with: @applicant.user_id
    click_on "Create Applicant"

    assert_text "Applicant was successfully created"
    click_on "Back"
  end

  test "should update Applicant" do
    visit applicant_url(@applicant)
    click_on "Edit this applicant", match: :first

    check "Hybrid option" if @applicant.hybrid_option
    fill_in "Perks", with: @applicant.perks
    fill_in "Rails level", with: @applicant.rails_level
    fill_in "Salary", with: @applicant.salary
    fill_in "Test score", with: @applicant.test_score
    fill_in "User", with: @applicant.user_id
    click_on "Update Applicant"

    assert_text "Applicant was successfully updated"
    click_on "Back"
  end

  test "should destroy Applicant" do
    visit applicant_url(@applicant)
    click_on "Destroy this applicant", match: :first

    assert_text "Applicant was successfully destroyed"
  end
end
