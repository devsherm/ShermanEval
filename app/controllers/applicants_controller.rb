class ApplicantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [:update, :edit]
  before_action :set_applicant, only: [:show, :edit, :update, :destroy]

  def index
    load_applicants
  end

  def new
    @applicant = current_user.applicants.new
  end

  def create
    @applicant = current_user.applicants.new(applicant_params)
    if @applicant.save
      redirect_to applicants_path, notice: 'Applicant was successfully created.'
    else
      render :new
    end
  end

  def show;end

  def edit;end

  def update
    if @applicant.update(status: applicant_params[:status].to_i )
      send_email
      redirect_to @applicant, notice: 'Applicant was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @applicant.destroy
    redirect_to applicants_url, notice: 'Applicant was successfully destroyed.'
  end

  private

  def send_email
    ApplicantMailer.send_email_to_applicant(applicant: @applicant, sender: current_user).deliver_now
  end

  def load_applicants
    if current_user.admin?
      @q = Applicant.ransack(params[:q])
    elsif current_user
      @q = current_user.applicants.ransack(params[:q])
    else
      redirect_to root_path, alert: 'You need to sign in to access this page.'
    end

    # Apply sorting if a sorting parameter is present
    if params[:q] && params[:q][:s]
      @q.sorts = params[:q][:s]
    end
    
    @pagy, @applicants = pagy(@q.result, items: 20)
  end

  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  def applicant_params
    if current_user.admin?
      params.require(:applicant).permit(:status)
    else
      params.require(:applicant).permit(:email, :full_name, :experience_summary, :primary_backend_language, tech_stack: [])
    end
  end
end
