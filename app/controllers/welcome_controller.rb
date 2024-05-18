class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  def spring_24_junior_rails_developer
  end
end
