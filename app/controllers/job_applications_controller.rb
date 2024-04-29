class JobApplicationsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only!
    
    def new
        render plain:render_to_string('job_applications/_create_new_job_applications_modal', layout: false)
    end
    def create
        job_application = JobApplication.new(job_title: params[:job_application][:job_title],
                                            job_department: params[:job_application][:job_department],
                                            job_position: params[:job_application][:job_position],
                                            job_description: params[:job_application][:job_description],
                                            created_by_id: current_user.id,
                                            updated_by_id: current_user.id,
                                            status: :active)

        if job_application.save
            redirect_to dashboard_path, notice: "Job Application was successfully created."
        else
            redirect_to dashboard_path, alert: format_error_msg(job_application)
        end
    end
end