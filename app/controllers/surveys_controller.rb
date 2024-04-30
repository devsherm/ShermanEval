class SurveysController < ApplicationController

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.user = current_user

    respond_to do |format|
      if @survey.save
        format.html { redirect_to survey_url(@survey), notice: "Survey was successfully created." }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def survey_params
      params.require(:survey).permit(:last_project, :favorite_cube, :like_ruby)
    end
end
