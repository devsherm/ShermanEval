class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @questionnaire = current_user.questionnaire
  end
end
