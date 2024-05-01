class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)
    # Check if any critical profile information is missing
    if user.admin
      # Redirect to the 'edit profile' page if the profile is incomplete
      dashboard_path
    else
      # Otherwise, proceed to wherever Devise would normally redirect
      super
    end
  end

  def admin_only!
    if user_signed_in?
      redirect_to "/404" unless current_user.admin
    end
  end

  def format_error_msg(controller)
    err_msg = '<ul class="p-4 max-w-md space-y-1 text-gray-500 list-disc list-inside">'
    controller.errors.full_messages.each do |msg|
      err_msg = err_msg+"<li>"+msg+"</li>"
    end
    err_msg = err_msg+"</ul>"
    return err_msg
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
