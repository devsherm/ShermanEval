class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!

  def authorize_admin!
    redirect_to applicants_path, alert: 'You are not authorized to perform this action.' unless current_user&.admin?
  end

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
end
