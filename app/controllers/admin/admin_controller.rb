class Admin::AdminController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_if_admin

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

  private

  def check_if_admin
    redirect_to root_path unless current_user.admin?
  end

end
