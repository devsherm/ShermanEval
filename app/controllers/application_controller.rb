# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  def after_sign_in_path_for(user)
    # Check if any critical profile information is missing
    if user.name.nil? || user.name.blank?
      # Redirect to the 'edit profile' page if the profile is incomplete
      edit_user_path(user)
    else
      # Otherwise, proceed to wherever Devise would normally redirect
      super
    end
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:alert] =
      error = I18n.t("pundit.#{policy_name}.#{exception.query}",
                     default: 'You are not authorized to perform this action.')
    respond_to do |format|
      format.html { redirect_to(request.referer || root_path) }
      format.json { render json: { errors: error }, status: 401 }
    end
  end
end
