class WelcomeController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :spring_24_junior_rails_developer ] 

  def index
    
  end
  def spring_24_junior_rails_developer
  end
end
