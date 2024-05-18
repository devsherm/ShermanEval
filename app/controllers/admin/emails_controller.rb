module Admin
  class EmailsController < BaseController
    before_action :set_email
    
    def new
    end

    def create
      respond_to do |format|
        if @email.save
          format.html { redirect_to admin_applicants_url, notice: "Success sending email to #{@email.email}" }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_email
      @email = Email.new(email_params)
    end

    def email_params
      params.require(:email).permit(:email, :subject, :body)
    end
  end
end