class UserApplicationsController < ApplicationController
  before_action :set_user_application, only: %i[ show edit update destroy update_status email_applicant ]

  # GET /user_applications or /user_applications.json
  def index
    # Since the sorting is custom and not a traditional table sort, we need to 
    # manually build the ransack query from our params
    @q = policy_scope(UserApplication).ransack(build_ransack_query(params))
    @q.sorts = 'last_name asc' if @q.sorts.empty?

    @user_applications = filter_user_applications

    # avoid n+1 query scenario since we call user#email for each user_application
    @user_applications.includes(:user)
  end

  # GET /user_applications/1 or /user_applications/1.json
  def show
    authorize @user_application
  end

  # GET /user_applications/new
  def new
    @user_application = authorize UserApplication.new
  end

  # GET /user_applications/1/edit
  def edit
    authorize @user_application
  end

  # POST /user_applications or /user_applications.json
  def create
    @user_application = authorize UserApplication.new(user_application_params)

    # when using collection checboxes, rails adds a hidden input field to ensure this param is always present even if no checkboxes are selected
    # this filters out blank entries
    @user_application.skills.reject!(&:blank?) if @user_application.skills.present?
    
    respond_to do |format|
      if @user_application.save
        format.html { redirect_to user_application_url(@user_application), notice: "User application was successfully created." }
        format.json { render :show, status: :created, location: @user_application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_applications/1 or /user_applications/1.json
  def update
    authorize @user_application

    respond_to do |format|
      if @user_application.update(user_application_params)
        format.html { redirect_to user_application_url(@user_application), notice: "User application was successfully updated." }
        format.json { render :show, status: :ok, location: @user_application }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_applications/1 or /user_applications/1.json
  def destroy
    @user_application = authorize @user_application
    @user_application.destroy

    respond_to do |format|
      format.html { redirect_to user_applications_url, notice: "User application was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update_status
    @user_application = authorize @user_application, :update?
    @user_application.update(score: params[:score])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "user_application_status_content#{@user_application.id}",
          partial: "user_applications/score",
          locals: { user_application: @user_application }
        )
      end
      format.html { redirect_to @user_application }
    end
  end

  def email_applicant
    authorize @user_application
    applicant = @user_application.user

    UserMailer.custom_email(applicant, params[:subject], params[:body]).deliver_now

    redirect_to root_path, notice: "Email successfully sent to #{@user_application.full_name}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_application
      @user_application = UserApplication.where(id: params[:id]).first
    end

    # Only allow a list of trusted parameters through.
    def user_application_params
      params.require(:user_application).permit(:first_name, :last_name, :user_id, :about_me, :gender, :score, skills: [])
    end

    # Since I'm using a custom sort instead of a table, this method formats the sort parameters for ransack
    def build_ransack_query(query_params)
      return {} unless query_params
      sort_query = "#{query_params[:sort_field]} #{query_params[:sort_direction]}" if query_params[:sort_field] && query_params[:sort_direction]
      query_params.merge(s: sort_query).except(:sort_field, :sort_direction)
    end

    def filter_user_applications
      # Filtering is only available to admins
      return @q.result if params[:score].blank? || !current_user.admin?

      case params[:score]
      when 'pending_review'
        @q.result.where(score: nil)
      when 'pass'
        @q.result.pass
      when 'follow_up'
        @q.result.follow_up
      when 'move_forward'
        @q.result.move_forward
      else
        @q.result
      end
    end
end
