require "test_helper"

class QuestionnairesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get questionnaires_new_url
    assert_response :success
  end

  test "should get create" do
    get questionnaires_create_url
    assert_response :success
  end

  test "should get show" do
    get questionnaires_show_url
    assert_response :success
  end

  test "should get index" do
    get questionnaires_index_url
    assert_response :success
  end

  test "should get edit" do
    get questionnaires_edit_url
    assert_response :success
  end

  test "should get update" do
    get questionnaires_update_url
    assert_response :success
  end

  test "should get destroy" do
    get questionnaires_destroy_url
    assert_response :success
  end
end
