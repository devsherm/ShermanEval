class UserApplicationsController < ApplicationController
  before_action :set_user_application, only: %i[edit update destroy]
  before_action :auth, only: %i[edit update destroy]

  def index
    @applications = policy_scope(UserApplication)
  end

  def new
    authorize UserApplication
    # We will assume that the first user always the employer
    @application = UserApplication.new(user: current_user, employer:)
  end

  def edit; end

  def create
    @application = current_user.job_applications.build(user_application_params)
    @application.employer = employer

    authorize @application

    if @application.save
      redirect_to user_applications_url, notice: 'Application was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    update_params = current_user.admin? ? admin_user_application_params : user_application_params

    if @application.update(update_params)
      redirect_to user_applications_url, notice: 'Application was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @application.destroy

    redirect_to user_applications_url, notice: 'Application was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_application
    @application = UserApplication.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_application_params
    params.require(:user_application).permit(:my_level, :scratch_before, :fav_hobby)
  end

  def admin_user_application_params
    params.require(:user_application).permit(:eval)
  end

  def auth
    authorize @application
  end

  def employer
    User.where(admin: true).first
  end
end
