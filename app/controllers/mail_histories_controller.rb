class MailHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [:index]

  def index
    load_applicants
  end

  private
  
  def load_applicants
    @pagy, @mail_histories = pagy(MailHistory.all, items: 20)
  end

end
