# app/controllers/users_controller.rb

class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # Display user profile
  def show
    @applicants = @user.applicants
  end

  # Display form for editing user profile
  def edit; end

  # Update user profile
  def update
    User.transaction do
      if @user.update(user_params)
        redirect_to user_path(@user), notice: 'User updated successfully.'
      else
        render :edit
        raise ActiveRecord::Rollback
      end
    end
  end

  # Delete a user
  def destroy
    if @user == current_user
      sign_out(@user) # Log out the user before deleting
      @user.destroy
      redirect_to root_path, notice: 'Your account has been deleted successfully.'
    else
      redirect_to root_path, alert: "You can't delete other users."
    end
  end

  # Create a new user
  def create
    User.transaction do
      if @user.save
        redirect_to user_path(@user), notice: 'User created successfully.'
      else
        render :new
        raise ActiveRecord::Rollback
      end
    end
  end

  # Helper methods
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
