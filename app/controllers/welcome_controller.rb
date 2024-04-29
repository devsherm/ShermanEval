class WelcomeController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :spring_24_junior_rails_developer ] 

  def index
    if current_user.admin
      redirect_to dashboard_path
    end

    @q = JobApplication.where(status: :active).ransack(params[:q])
    @job_applications = @q.result.order(updated_at: :desc)
  end

  def spring_24_junior_rails_developer
  end
end
