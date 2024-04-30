class JobSubmissionsController < ApplicationController

    def create
        
        @job_submissions = JobSubmission.where(created_by_id: current_user.id, job_application_id: params[:job_submission][:job_application_id])
        
        if @job_submissions.length == 0
            @form_submission = JobSubmission.new(job_submission_params)
            @form_submission.created_by_id = current_user.id
            @form_submission.updated_by_id = current_user.id

            if validate_data_params(params[:job_submission][:job_submission_data])
                if @form_submission.save
                    redirect_to job_application_path(id: params[:job_submission][:job_application_id]), notice: "Job Application was successfully submitted."
                else
                    redirect_to apply_job_submission_path(job_application_id: params[:job_submission][:job_application_id]), alert: format_error_msg(@form_submission)
                end
            else
                redirect_to apply_job_submission_path(job_application_id: params[:job_submission][:job_application_id]), alert: format_error_msg(@form_submission)
            end
        else
            redirect_to job_application_path(id: params[:job_submission][:job_application_id]), alert: "You have already submitted this job application."
        end
    end

    def apply
        @job_application = JobApplication.find(params[:job_application_id]) 
    end

    def show
        @job_submission = JobSubmission.find(params[:id]) 
    end

    def validate_data_params(data_params)
        required_keys = [:values, :hosting, :database, :pay_range, :work_schedule, :expected_work_schedule]
        return required_keys.all? { |key| data_params[key].present? }
    end

    private

    def job_submission_params
        params.require(:job_submission).permit(:job_application_id, :status, :create_by_id, :update_by_id, job_submission_data: {} )
    end
end