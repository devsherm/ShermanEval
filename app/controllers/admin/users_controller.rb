module Admin
    class UsersController < ApplicationController
        def review_applications
            @job_applications = JobApplication.all
            @job_applications = @job_applications.order(status: params[:sort_order] == 'desc' ? :desc : :asc)
            @job_applications = @job_applications.where.not(status: 2) unless params[:show_rejected]
          end
  
      def user_application
        @job_application = JobApplication.find_by(email: params[:id])
      end
  
      def show
        @user = User.find(params[:id])
        @job_application = JobApplication.find_by(user_id: @user.id)
  
        if current_user != @user && !current_user.admin?
          redirect_to root_path, alert: "You are not authorized to view this page."
          return
        end
      end
  
      def update_status
        @user = User.find(params[:id])
        @job_application = JobApplication.find_by(user_id: @user.id)
  
        if @job_application.update(job_application_params)
        else
          render :show
        end
      end

      def send_status_update_email
        @user = User.find(params[:id])
        @job_application = JobApplication.find_by(user_id: @user.id)
  
        ApplicationMailer.status_update_email(@user.email).deliver_now
        redirect_to [:admin, @user], notice: 'Status update email was successfully sent.'
      end

      private
  
      def job_application_params
        params.require(:job_application).permit(:user_id, :about, :experience_level, :remote_ok, :resume, :status)
      end
    end
  end