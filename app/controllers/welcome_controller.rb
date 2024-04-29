class WelcomeController < ApplicationController
  before_action :authenticate_user!, only: %i[ index, spring_24_junior_rails_developer ] 

  def spring_24_junior_rails_developer
  end
end
