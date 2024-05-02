class ApplicantsController < ApplicationController
  before_action :set_applicant, only: %i[ show edit update destroy contact ]
  before_action :set_user, only: %i[ new create ]

  # GET /applicants
  ### GET /users/:user_id/applicants
  def index
    @applicants = policy_scope(Applicant).paginate(page: params[:page], per_page: 10)
    @new_applicants = policy_scope(Applicant).where(eval: nil).paginate(page: params[:page], per_page: 10)
    @evaluated_applicants = policy_scope(Applicant).where.not(eval: nil).order("eval DESC").paginate(page: params[:page], per_page: 10)
  end

  # GET /applicants/:id
  def show
    authorize @applicant
  end

  # GET /users/:user_id/applicants/new
  def new
    authorize Applicant
    @applicant = current_user.applicants.build
  end

  # GET /applicants/:id/edit
  def edit
    authorize @applicant
  end

  # POST /applicants
  # POST /users/:user_id/applicants
  def create
    @applicant = current_user.applicants.build(applicant_params)

    authorize @applicant

    respond_to do |format|
      if @applicant.save
        format.html { redirect_to applicants_url, notice: "Applicant was successfully created." }
        format.json { render :show, status: :created, location: @applicant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applicants/:id
  def update
    authorize @applicant
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to applicants_url, notice: "Applicant was successfully updated." }
        format.json { render :show, status: :ok, location: @applicant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicants/:id
  def destroy
    authorize(@applicant)
    @applicant.destroy

    respond_to do |format|
      format.html { redirect_to applicants_url, notice: "Applicant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /applicants/:id/contact
  def contact
    authorize(@applicant)
    content = params[:body]
    subject= params[:subject]
    ApplicantMailer.contact_applicant(subject, content, @applicant.user.name, @applicant.user.email).deliver_now
    @applicant.update(contacted: true)
    respond_to do |format|
      format.html { redirect_to edit_applicant_path(@applicant), notice: "Message sent." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_applicant
      @applicant = Applicant.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def applicant_params
      params.require(:applicant).permit(:user_id, :my_level, :full_time, :fav_pet, :eval)
    end
end
