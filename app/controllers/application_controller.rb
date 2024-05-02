class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!
  # after_action development helpers
  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index

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

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def user_not_authorized
      redirect_to request.referrer || root_path, alert: "You are not authorized to perform this action."
    end
end
