module Admin
  class BaseController < ApplicationController
    before_action :check_user_admin
  
    private
  
    def check_user_admin
      return if current_user.admin?
  
      redirect_to root_path, flash: { errors: "you not authorized to access" }
    end
  end  
end