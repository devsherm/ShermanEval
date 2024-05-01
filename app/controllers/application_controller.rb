class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!

  # Show generic 404s in production for pundit errors
  if Rails.env.production?
    # Rescue from a pundit authorization error
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    # Rescue from NoMethodError or similar if you suspect nil objects might be authorized
    rescue_from Pundit::NotDefinedError, with: :handle_nil_class_error
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

  private
    # Show a generic 404 so we don't give unnecessary information to potential attackers that a record
    # exists at a certain URL
    def user_not_authorized
      render_404
    end

    # Handle when an authorization check fails to find a record
    def handle_nil_class_error(exception)
      logger.error "NilClassError: #{exception.message} at #{exception.backtrace.first}"

      render_404
    end

    def render_404
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
end
