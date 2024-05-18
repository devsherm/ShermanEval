class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, with: :handle_routing_error
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

  def handle_routing_error
    redirect_to root_path, alert: "The requested page does not exist."
  end

  private
  # any other private methods
end
