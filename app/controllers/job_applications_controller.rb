class JobApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job_application
  before_action -> { redirect_to root_path if current_user.admin? }, only: %i[new show update create edit destroy ]
  ALLOWED_COLUMNS = %w[name email created_at status]
  ALLOWED_DIRECTIONS = %w[asc desc]

  # GET /job_applications or /job_applications.json
  def index
    @job_applications = JobApplication.page(params[:page]).per(10)
  
    # Filter by status if 'status' parameter is present
    @job_applications = @job_applications.where(status: params[:status]) if params[:status].present?
  
    # Apply sorting, and ordering
    sort_column = params[:column].presence_in(ALLOWED_COLUMNS) || 'updated_at'
    sort_direction = params[:direction].presence_in(ALLOWED_DIRECTIONS) || 'desc'
    sort_hash = { sort_column => sort_direction }

    @job_applications = @job_applications.order(sort_hash)
  end
  
  # GET job_applications/1/view
  def view 
    id = params[:id]
    @job_application = JobApplication.find(id)
    if @job_application.nil?
      redirect_to root_path
    end
  end

  # PATCH/PUT /job_applications/1/view
  def change_status
    if @job_application.update(status: job_application_params[:status])
      redirect_to job_application_url(@job_application), notice: "Status updated."
    else
      render :view, status: :unprocessable_entity
    end
  end

  # GET /job_applications/1 or /job_applications/1.json
  def show
    if @job_application.nil?
      redirect_to new_job_application_path
    end
  end

  # GET /job_applications/new
  def new
    if @job_application.present?
      redirect_to job_application_path(@job_application)
    else
      @job_application = JobApplication.new
    end
  end

  # GET /job_applications/1/edit
  def edit
    @job_application = JobApplication.find_by(user_id: current_user.id)
    if @job_application.nil?
      redirect_to new_job_application_path
    end
  end

  # POST /job_applications or /job_applications.json
  def create
    @job_application = JobApplication.new(job_application_params)
    if @job_application.save
      redirect_to root_path, notice: "Application submitted!"
    else
      flash[:alert] = @job_application.errors.full_messages.join('. ')
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /job_applications/1 or /job_applications/1.json
  def update
    respond_to do |format|
      if @job_application.update(job_application_params)
        format.html { redirect_to job_application_url(@job_application), notice: "Job application was successfully updated." }
        format.json { render :show, status: :ok, location: @job_application }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /job_applications/1 or /job_applications/1.json
  # def destroy
  #   @job_application.destroy

  #   respond_to do |format|
  #     format.html { redirect_to job_applications_url, notice: "Job application was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_application
      if current_user.admin?
        @job_application = JobApplication.find_by(id: params[:id])
      else
        @job_application = JobApplication.find_by(user_id: current_user.id)
      end
    end

    # Only allow a list of trusted parameters through.
    def job_application_params
      params.require(:job_application).permit(:summary, :experience, :git_competence, :rails_competence, :preferred_contact, :terms, :status, :page).merge(user_id: current_user.id, email: current_user.email, name: current_user.name)
    end
end