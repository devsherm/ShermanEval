# frozen_string_literal: true

class ApplicantsController < ApplicationController
  before_action :set_applicant, only: %i[show edit update destroy]
  before_action :set_user, only: %i[new create]

  # GET /applicants or /applicants.json
  def index
    @applicants = if current_user.admin?
                    Applicant.all
                  else
                    current_user.applicants.all
                  end
  end

  # GET /applicants/1 or /applicants/1.json
  def show
    authorize @applicant
    @applicant = Applicant.find(params[:id])
  end

  # GET /applicants/new
  def new
    authorize Applicant
    @applicant = current_user.applicants.build
  end

  # GET /applicants/1/edit
  def edit
    authorize @applicant, :create?
  end

  # POST /applicants or /applicants.json
  def create
    @applicant = current_user.applicants.build(applicant_params)

    authorize @applicant, :create?

    respond_to do |format|
      if @applicant.save
        format.html { redirect_to applicants_url, notice: 'Applicant was successfully created.' }
        format.json { render :show, status: :created, location: @applicant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applicants/1 or /applicants/1.json
  def update
    authorize @applicant
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to applicants_url, notice: 'Applicant was successfully updated.' }
        format.json { render :show, status: :ok, location: @applicant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicants/1 or /applicants/1.json
  def destroy
    authorize @applicant
    @applicant.destroy

    respond_to do |format|
      format.html { redirect_to applicants_url, notice: 'Applicant was successfully destroyed.' }
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
    params.require(:applicant).permit(
      :first_name,
      :last_name,
      :email,
      :age,
      :gender,
      :score,
      skills: []
    )
  end
end
