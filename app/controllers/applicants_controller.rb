class ApplicantsController < ApplicationController
  before_action :set_applicant, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[ new create ]

  # GET /applicants or /applicants.json
  def index
    if params[:sort_by] == "highest_score"
      @applicants = Applicant.highest_score
    elsif params[:sort_by] == "most_available"
      @applicants = Applicant.most_available
    else
      @applicants = Applicant.most_recent
    end
  end

  # GET /applicants/1 or /applicants/1.json
  def show
  end

  # GET /applicants/new
  def new
    @applicant = Applicant.new
  end

  # GET /applicants/1/edit
  def edit
  end

  # POST /applicants or /applicants.json
  def create
    @applicant = current_user.applicants.build(applicant_params)

    respond_to do |format|
      if @applicant.save
        format.html { redirect_to applicants_url(@applicant), notice: "Applicant was successfully created." }
        format.json { render :show, status: :created, location: @applicant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applicants/1 or /applicants/1.json
  def update
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to applicant_url(@applicant), notice: "Applicant was successfully updated." }
        format.json { render :show, status: :ok, location: @applicant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicants/1 or /applicants/1.json
  def destroy
    @applicant.destroy

    respond_to do |format|
      format.html { redirect_to applicants_url, notice: "Applicant was successfully destroyed." }
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
      params.require(:applicant).permit(:user_id, :name, :email, :experience, availability:[])
    end
end
