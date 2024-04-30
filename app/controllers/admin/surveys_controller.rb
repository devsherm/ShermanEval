class Admin::SurveysController < Admin::AdminController
  before_action :set_survey, only: %i[ show deny ]
  before_action :find_survey, only: %i[ deny hold approve reset ]
  layout 'application'

  def index
    @surveys = Survey.includes(:user).order("evaluation", "created_at").all
    render template: "surveys/index"
  end

  def show
    render template: "surveys/show"
  end

  def reset
    respond_to do |format|
      if @survey.update({evaluation: ''})
        format.html { redirect_to admin_surveys_path, notice: "Survey was successfully updated." }
      else
        format.html { redirect_to admin_surveys_path, alert: "Survey was not updated." }
      end
    end
  end

  def hold
    respond_to do |format|
      if @survey.update({evaluation: '1-held'})
        format.html { redirect_to admin_surveys_path, notice: "Survey was successfully updated." }
      else
        format.html { redirect_to admin_surveys_path, alert: "Survey was not updated." }
      end
    end
  end

  def approve
    respond_to do |format|
      if @survey.update({evaluation: '2-approved'})
        format.html { redirect_to admin_surveys_path, notice: "Survey was successfully updated." }
      else
        format.html { redirect_to admin_surveys_path, alert: "Survey was not updated." }
      end
    end
  end

  def deny
    respond_to do |format|
      if @survey.update({evaluation: '3-denied'})
        format.html { redirect_to admin_surveys_path, notice: "Survey was successfully updated." }
      else
        format.html { redirect_to admin_surveys_path, alert: "Survey was not updated." }
      end
    end
  end

  private
    def set_survey
      @survey = Survey.where("user_id = ?", current_user.id).first
    end

    def find_survey
      @survey = Survey.find(params[:id])
    end

    def survey_params
      params.require(:survey).permit(:last_project, :favorite_cube, :like_ruby)
    end
end
