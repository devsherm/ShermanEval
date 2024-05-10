class ApplicantsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index new create]

  def index
    @applicants = Applicant.all
    if current_user and not current_user.admin
      @applicant = Applicant.find_by(user_id: current_user.id)
    else
      @applicant = nil
    end
  end

  def show
    @applicant = Applicant.find(params[:id])
    @categories = Category.where.not(id: @applicant.applicant_categories.map { |e| e.category_id })
  end

  def new
    @questions = Question.all
    @user = User.new
    @applicant = Applicant.new(user: @user, answers: @questions.map { |q| Answer.new(question: q) })
  end

  def create
    # TODO: remove this hack
    handle_arrays_in_params

    @user = User.new(user_params)
    @applicant = Applicant.new(user: @user, answers_attributes: applicant_params[:answers_attributes])

    if @user.save
      @applicant.user = @user
      if @applicant.save
	sign_in @user
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
    @user = @applicant.user
  end

  def update
    @applicant = Applicant.find(params[:id])

    # TODO: remove this hack
    handle_arrays_in_params

    if not @applicant.user.update(user_params)
      @applicant.user.errors.add("cannot update user information")
    end

    if @applicant.update(applicant_params)
      # TODO: looks like here we should reset assigned categories becasue application was chnaged and we need review it agagin
      redirect_to @applicant
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def applicant_params
      params.require(:applicant).permit(answers_attributes: [:question_id, :id, :value, value: []])
    end

    def user_params
      params.require(:applicant).require(:user).permit(:name, :email, :password)
    end

    def handle_arrays_in_params
      # TODO: remove this hack
      if params[:applicant].has_key? :answers_attributes
        params[:applicant][:answers_attributes].each_value { |v| if v[:value].is_a?(Array) then v[:value] = v[:value].compact_blank.join("\n") else v end  }
        params[:applicant][:answers_attributes].each_value { |v| if v[:fixed_value].is_a?(Array) then v[:value] = v[:fixed_value].compact_blank.join("\n") else v end  }
      end
      params
    end
end
