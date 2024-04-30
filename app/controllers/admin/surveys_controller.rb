class Admin::SurveysController < Admin::AdminController
  before_action :set_survey, only: %i[ show ]
  layout 'application'

  def index
    @surveys = Survey.includes(:user).order("evaluation", "created_at").all
    render template: "surveys/index"
  end

  def show
    render template: "surveys/show"
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
