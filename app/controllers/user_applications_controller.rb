class UserApplicationsController < ApplicationController
  before_action :set_user_application, only: %i[ show edit update destroy ]

  # GET /user_applications or /user_applications.json
  def index
    @user_applications = UserApplication.all
  end

  # GET /user_applications/1 or /user_applications/1.json
  def show
  end

  # GET /user_applications/new
  def new
    @user_application = UserApplication.new
  end

  # GET /user_applications/1/edit
  def edit
  end

  # POST /user_applications or /user_applications.json
  def create
    @user_application = UserApplication.new(user_application_params)

    respond_to do |format|
      if @user_application.save
        format.html { redirect_to user_application_url(@user_application), notice: "User application was successfully created." }
        format.json { render :show, status: :created, location: @user_application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_applications/1 or /user_applications/1.json
  def update
    respond_to do |format|
      if @user_application.update(user_application_params)
        format.html { redirect_to user_application_url(@user_application), notice: "User application was successfully updated." }
        format.json { render :show, status: :ok, location: @user_application }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_applications/1 or /user_applications/1.json
  def destroy
    @user_application.destroy

    respond_to do |format|
      format.html { redirect_to user_applications_url, notice: "User application was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_application
      @user_application = UserApplication.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_application_params
      params.require(:user_application).permit(:first_name, :last_name, :user_id, :skills, :about_me, :gender, :score)
    end
end
