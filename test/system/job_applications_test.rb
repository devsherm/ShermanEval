require "application_system_test_case"

class JobApplicationsTest < ApplicationSystemTestCase
  setup do
    @job_application = job_applications(:one)
  end

  test "visiting the index" do
    visit job_applications_url
    assert_selector "h1", text: "Job applications"
  end

  test "should create job application" do
    visit job_applications_url
    click_on "New job application"

    click_on "Create Job application"

    assert_text "Job application was successfully created"
    click_on "Back"
  end

  test "should update Job application" do
    visit job_application_url(@job_application)
    click_on "Edit this job application", match: :first

    click_on "Update Job application"

    assert_text "Job application was successfully updated"
    click_on "Back"
  end

  test "should destroy Job application" do
    visit job_application_url(@job_application)
    click_on "Destroy this job application", match: :first

    assert_text "Job application was successfully destroyed"
  end
end
