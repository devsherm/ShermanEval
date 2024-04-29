class ApplicantsController < ApplicationController
  before_action :set_applicant

  # PATCH/PUT /applicants/1 or /applicants/1.json
  def update
    @applicant.assign_attributes(applicant_params)
    @applicant.save
    
    render :show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_applicant
    @applicant = Applicant.find_or_initialize_by(user: current_user)
  end

  # Only allow a list of trusted parameters through.
  def applicant_params
    params.require(:applicant).permit(:user_id, :salary, :hybrid_option, :rails_level, :test_score, perks: [])
  end
end
