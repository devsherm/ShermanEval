class ApplicantsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]

  def index
    @applicants = Applicant.all
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(applicant_params)

    if @applicant.save
      redirect_to @applicant
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @applicant = Applicant.find(params[:id])
  end

  def update
    @applicant = Applicant.find(params[:id])

    #debugger
    params[:applicant][:answers_attributes].each_value { |v| if v[:value].is_a?(Array) then v[:value] = v[:value].compact_blank.join("\n") else v end  }
    p = params.require(:applicant).permit(answers_attributes: [:id, :value])
    if @applicant.update(p)
      redirect_to @applicant
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def applicant_params
      params.require(:applicant).permit(answers_attributes: [:value, :id])
    end
end
