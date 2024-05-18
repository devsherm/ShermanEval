class AdminMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.post_created.subject
  #
  def post_created
    @applicant = params[:applicant]
    @greeting = "Hello,"

    mail from: "eval@shermaneval.com", to: @applicant.email, cc: "admin@shermaneval.com", subject: "ShermanEval: Regarding the status of your application"
  end
end
