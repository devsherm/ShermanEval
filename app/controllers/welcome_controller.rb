class WelcomeController < ApplicationController
  def index
    if current_user.admin?
      redirect_to review_applications_admin_users_path
    end
  end

  def spring_24_junior_rails_developer
  end
end