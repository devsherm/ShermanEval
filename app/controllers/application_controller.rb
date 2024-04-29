class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

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

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
end
