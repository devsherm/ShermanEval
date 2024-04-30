class JobApplicationsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only!, only: [:index, :new, :create, :edit, :update, :destroy]

    def new
        render plain:render_to_string('job_applications/_create_new_job_applications_modal', layout: false)
    end

    def create
        job_application = JobApplication.new(job_application_params)
        job_application.created_by_id = current_user.id
        job_application.updated_by_id = current_user.id
        job_application.status = :active

        if job_application.save
            redirect_to dashboard_path, notice: "Job Application was successfully created."
        else
            redirect_to dashboard_path, alert: format_error_msg(job_application)
        end
    end

    def show
        @job_application = JobApplication.find(params[:id])
    end

    def edit
        @job_application = JobApplication.find(params[:id])
    end

    def update
        job_application = JobApplication.find(params[:id])
        if job_application.update(job_application_params)
            redirect_to edit_job_application_path(job_application), notice: "Job Application was successfully updated."
        else
            redirect_to edit_job_application_path(job_application), alert: format_error_msg(job_application)
        end
    end

    def destroy
        job_application = JobApplication.find(params[:id])
        if job_application.status_active? && job_application.update(status: :deleted, updated_by_id: current_user.id)
            redirect_to dashboard_path, notice: "Job Application was successfully deleted."
        elsif job_application.status_deleted? && job_application.update(status: :active, updated_by_id: current_user.id)
            redirect_to dashboard_path, notice: "Job Application was successfully activated."
        else
            redirect_to dashboard_path, alert: format_error_msg(job_application)
        end
    end

    private

    def job_application_params
        params.require(:job_application).permit(:job_title, :job_description, :job_position,:job_department, :status, :create_by_id, :update_by_id)
    end



end