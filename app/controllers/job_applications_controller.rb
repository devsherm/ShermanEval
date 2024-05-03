class JobApplicationsController < ApplicationController
    before_action :set_job_application, only: [:show]
  
    def new
      @job_application = JobApplication.new
    end
  
    def create
        @job_application = JobApplication.new(job_application_params)
        @job_application.user = current_user
        @job_application.email = current_user.email
      
        if @job_application.save
          redirect_to submitted_job_applications_path
        else
          render :new
        end
      end
  
    def show
      # The @job_application instance variable is already set by the before_action
    end
  
    private
  
    def set_job_application
        user = User.find_by(email: params[:email])
        if user
          @job_application = JobApplication.find_by(user_id: user.id)
        else
          flash[:error] = "User with email #{params[:email]} not found"
          redirect_to root_path # or wherever you want to redirect to
        end
      end
  
    def job_application_params
      params.require(:job_application).permit(:name, :experience_level, :remote_ok, :email)
    end
  end