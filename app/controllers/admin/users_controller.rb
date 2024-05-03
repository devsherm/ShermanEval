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
  
        if current_user != @user && !current_user.admin?
          redirect_to root_path, alert: "You are not authorized to view this page."
          return
        end
      end
  
      def update_status
        @user = User.find(params[:id])
        @job_application = JobApplication.find_by(user_id: @user.id)
  
        if @job_application.update(job_application_params)
          redirect_to admin_user_path(@user), notice: 'Job application status was successfully updated.'
        else
          render :show
        end
      end

      private
  
      def job_application_params
        params.require(:job_application).permit(:status)
      end
    end
  end