ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors, with: :threads)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def create_user(email, admin: false)
    User.create!(email:, password: 'password!', password_confirmation: 'password!', admin:)
  end

  def create_user_application(user, employer, fav_hobby: 'reading', my_level: :beginner, scratch_before: 'yes')
    UserApplication.create!(user:, employer:, fav_hobby:, my_level:, scratch_before:)
  end
end
