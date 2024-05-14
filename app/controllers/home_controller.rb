class HomeController < ApplicationController
  before_action :authenticate_user!, :set_job_application, :redirect_admin

  def index
  end
  def set_job_application
    @job_application = JobApplication.find_by(user_id: current_user.id)
  end

  def redirect_admin
    if current_user&.admin?
      redirect_to job_applications_path
    elsif @job_application.present?
      redirect_to job_application_path(@job_application)
    else
      redirect_to new_job_application_path
    end
  end
end
