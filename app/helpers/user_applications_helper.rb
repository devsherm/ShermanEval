module UserApplicationsHelper
  def show_new_application_button?
    # the admin shouldn't submit applications, but they have the functionality in case they need to test
    return true if current_user.admin?

    current_user.applications.none?
  end

  def index_header
    return "User Applications" if current_user.admin?

    "My Applications"
  end
end
