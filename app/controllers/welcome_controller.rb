class WelcomeController < ApplicationController
  include Pagy::Backend
  
  before_action :authenticate_user!, only: [ :index, :spring_24_junior_rails_developer ] 

  def index
    if current_user.admin
      redirect_to dashboard_path
    end

    @q = JobApplication.where(status: :active).ransack(params[:q])
    @job_applications = @q.result.order(updated_at: :desc)
    @pagy, @job_applications = pagy(@job_applications)
  end

  def contact_us_email
    ContactMailer.contact_us(params[:email],params[:subject],params[:message]).deliver_later
    redirect_to contact_us_path, notice: 'Thank you for contacting us. We will get back to you shortly.'
  end

  def spring_24_junior_rails_developer
  end
end
