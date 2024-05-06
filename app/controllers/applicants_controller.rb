class ApplicantsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def index
    @applicants = Applicant.all
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

  def new
    @questions = Question.all
    @user = User.new
    @applicant = Applicant.new(user: @user, answers: @questions.map { |q| Answer.new(question: q) })
  end

  def create
    # TODO: remove this hack
    params[:applicant][:answers_attributes].each_value { |v| if v[:value].is_a?(Array) then v[:value] = v[:value].compact_blank.join("\n") else v end  }

    @user = User.new(params.require(:applicant).require(:user).permit(:name, :email, :password))
    # params.require(:applicant).permit(user: [:name, :email], answers_attributes: [:id, :value])
    p = params.require(:applicant).permit(answers_attributes: [:value, :id, :question_id])
    @applicant = Applicant.new(user: @user, answers_attributes: p[:answers_attributes])
    if @user.save
      #redirect_to user_url(@user), notice: "User was successfully created."
      @applicant.user = @user
      if @applicant.save
        redirect_to @applicant
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @applicant = Applicant.find(params[:id])
    @questions = Question.all
  end

  def update
    @applicant = Applicant.find(params[:id])

    #debugger
    # TODO: remove this hack
    params[:applicant][:answers_attributes].each_value { |v| if v[:value].is_a?(Array) then v[:value] = v[:value].compact_blank.join("\n") else v end  }

    if @applicant.update(applicant_params)
      redirect_to @applicant
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def applicant_params
      params.require(:applicant).permit(:user, answers_attributes: [:id, :value])
    end
end
