class AdminsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only!

    def index
        @q = JobApplication.all.ransack(params[:q])
        @job_applications = @q.result.order(updated_at: :desc)
    end
end