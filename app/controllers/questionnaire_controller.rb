class QuestionnaireController < ApplicationController
  def questionnaire
    if Applicant.where(:email => current_user.email).blank?
      @applicant = Applicant.new
    else
      redirect_to viewer_path
    end
  end

  def viewer
    @applicant = Applicant.find_by_email(current_user.email)
  end

  def create
    @applicant = Applicant.new(applicant_params)
    if @applicant.save
      redirect_to viewer_path, notice: "Application saved successfully"
    else
      render :questionnaire, status: :unprocessable_entity
    end
  end

  private

  def applicant_params
    params[:applicant]["email"] = current_user.email
    params.require(:applicant).permit(:email, :full_name, :how_find, :knows_mvc, :knows_rails, :knows_ruby)
  end
end
