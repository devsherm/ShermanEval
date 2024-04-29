require 'test_helper'

class UserApplicationTest < ActiveSupport::TestCase
  teardown do
    User.destroy_all
  end

  test 'can create a user application' do
    user = create_user('applicant@test.com')
    employer = create_user('employer@test.com', admin: true)

    application = create_user_application(user, employer)

    assert application.valid?
  end

  test 'cannot create application with non-admin employer' do
    user = create_user('applicant@test.com')
    employer = create_user('employer@test.com', admin: false)

    application = UserApplication.new(user:, employer:)

    assert application.valid? == false
    assert application.errors[:employer].present?
  end
end
