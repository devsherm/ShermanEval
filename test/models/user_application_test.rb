require "test_helper"

class UserApplicationTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @user_application = UserApplication.new(
      user: @user,
      first_name: "John",
      last_name: "Doe",
      skills: "ruby"
    )
  end

  test "should be valid" do
    assert @user_application.valid?
  end

  test "should require user" do
    @user_application.user = nil
    assert_not @user_application.valid?
  end

  test "should require first name" do
    @user_application.first_name = ""
    assert_not @user_application.valid?
  end

  test "should require last name" do
    @user_application.last_name = ""
    assert_not @user_application.valid?
  end

  test "first name should contain only valid characters" do
    @user_application.first_name = "John$"
    assert_not @user_application.valid?
  end

  test "last name should contain only valid characters" do
    @user_application.last_name = "Doe$"
    assert_not @user_application.valid?
  end

  test "skills should be present" do
    @user_application.skills = ""
    assert_not @user_application.valid?
  end

  test "skills should be in available skills list" do
    @user_application.skills = "invalid_skill"
    assert_not @user_application.valid?
  end
end
