class AdminViewController < ApplicationController
  def admin_view
    @applicants = Applicant.order(params[:sort])
  end

  def update
    @applicant = Applicant.find(params[:id])
    if params[:status].present? then
      @applicant.update(status: params[:status])
    end
    redirect_to admin_path, notice: "Status for #{@applicant.full_name} updated to #{@applicant.status}"
  end

  def delete
    applicant = Applicant.find_by_email(params[:email])
    applicant.destroy
  end

  def email
    @applicant = Applicant.find(params[:format])
    redirect_to admin_path, notice: "Sent email to #{@applicant.full_name}, regarding their status update to #{@applicant.status}"
    AdminMailer.with(applicant: @applicant).post_created.deliver_later
  end
end
