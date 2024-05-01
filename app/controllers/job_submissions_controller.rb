class JobSubmissionsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only!, only: [:manage, :update, :send_note, :notify]

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
                redirect_to apply_job_submission_path(job_application_id: params[:job_submission][:job_application_id]), alert: "Please fill out all required fields."
            end
        else
            redirect_to job_application_path(id: params[:job_submission][:job_application_id]), alert: "You have already submitted this job application."
        end
    end

    def update
        @job_submissions = JobSubmission.find(params[:id])
        if @job_submissions.update(job_submission_params)
            redirect_to manage_job_submission_path(id:@job_submissions.job_application_id), notice: "Job Submission was successfully updated."
        else
            redirect_to job_submission_path(id: params[:id]), alert: format_error_msg(@job_submissions)
        end

    end

    def apply
        @job_application = JobApplication.find(params[:job_application_id]) 
    end

    def show
        @job_submission = JobSubmission.find(params[:id]) 
    end

    def manage
        @job_application = JobApplication.find(params[:id])
        @q = JobSubmission.where(job_application_id: params[:id]).ransack(params[:q])
        @job_submissions = @q.result.includes(:user)
    end

    def notify
        @submission = JobSubmission.find(params[:id])
        render plain:render_to_string('job_submissions/_send_note_to_applicant_modal', layout: false)
    end

    def send_note
        @submission = JobSubmission.find(params[:id])
        @submission.updated_by_id = current_user.id
        @submission.note_sent_at = Time.now
        
        if @submission.update(job_submission_params)
            NotifyApplicantMailer.notify_email(User.first,@submission.note_to_applicant,@submission.job_application.job_title,@submission.status.humanize).deliver_later
            redirect_to job_submission_path(id:@submission.id), notice: "Note was successfully sent."
        else
            redirect_to job_submission_path(id:@submission.id), alert: format_error_msg(@submission)
        end
        
    end

    def validate_data_params(data_params)
        if !data_params.nil?
            required_keys = [:values, :hosting, :database, :pay_range, :work_schedule, :expected_work_schedule]
            return required_keys.all? { |key| data_params[key].present? }
        else
            return false
        end
    end

    private

    def job_submission_params
        params.require(:job_submission).permit(:job_application_id, :note_to_applicant, :status, :create_by_id, :update_by_id, job_submission_data: {} )
    end
end