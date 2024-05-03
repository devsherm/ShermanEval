module Admin
    class UserApplicationsController < ApplicationController
      def show
        @user_application = UserApplication.find(params[:id])
      end
    end
  end