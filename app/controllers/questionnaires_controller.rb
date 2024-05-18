class QuestionnairesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  before_action :authenticate_user!
  before_action :set_questionnaire, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:index, :send_email]

  def index
    @questionnaires = Questionnaire.all
  end

  def show
    redirect_to root_path unless current_user.admin? || current_user == @questionnaire.user
  end

  def new
    @questionnaire = Questionnaire.new
  end

  def create
    # Check if the user already has a questionnaire
    if current_user.questionnaire.present?
      redirect_to current_user.questionnaire, alert: 'You have already created a questionnaire.'
      return
    end
    
    sanitized_params = questionnaire_params
    sanitized_params[:long_text] = sanitize(sanitized_params[:long_text])
    sanitized_params[:short_text] = sanitize(sanitized_params[:short_text])
    @questionnaire = current_user.build_questionnaire(sanitized_params)

    if @questionnaire.save
      redirect_to @questionnaire, notice: 'Questionnaire was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    sanitized_params = questionnaire_params
    # Sanitize each text and textarea input
    sanitized_params[:long_text] = sanitize(sanitized_params[:long_text])
    sanitized_params[:short_text] = sanitize(sanitized_params[:short_text])
    sanitized_params[:category] = sanitize(sanitized_params[:category]) if current_user.admin?

    if @questionnaire.update(sanitized_params)
      redirect_to @questionnaire, notice: 'Questionnaire was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @questionnaire.destroy
    if current_user.admin?
      redirect_to questionnaires_path, notice: 'Questionnaire was successfully destroyed.'
    else
      redirect_to root_path, notice: 'You have successfully deleted your questionnaire.'
    end
  end

  def send_email
    user_email = params[:to]
    cc = params[:cc]
    message_body = params[:message]

    # Assuming you have a method to find a user by email to pass as a parameter to the mailer
    user = User.find_by(email: user_email)
    
    # Send the email immediately
    UserMailer.send_questionnaire_email(user, cc, message_body).deliver_now
  
    # Redirect to the questionnaires index with a notice
    redirect_to questionnaires_path, notice: "Email sent successfully."
  end

  private
  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  def questionnaire_params
    params.require(:questionnaire).permit(:long_text, :short_text, :radio_choice, :checkbox, :category)
  end

  def check_admin
    redirect_to root_path unless current_user.admin?
  end
end

