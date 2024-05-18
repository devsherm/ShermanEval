module Admin
  class ApplicantsController < BaseController
    before_action :set_applicant, only: %i[ show edit update destroy ]
  
    # GET /applicants or /applicants.json
    def index
      @applicants = Applicant.includes(:user).search_and_orders(search_and_orders_params)
    end
  
    # GET /applicants/1 or /applicants/1.json
    def show
    end
  
    # GET /applicants/new
    def new
      @applicant = Applicant.new
    end
  
    # GET /applicants/1/edit
    def edit
    end
  
    # POST /applicants or /applicants.json
    def create
      @applicant = Applicant.new(applicant_params)
  
      respond_to do |format|
        if @applicant.save
          format.html { redirect_to admin_applicant_url(@applicant), notice: "Applicant was successfully created." }
          format.json { render :show, status: :created, location: @applicant }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @applicant.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /applicants/1 or /applicants/1.json
    def update
      respond_to do |format|
        if @applicant.update(applicant_params)
          format.html { redirect_to admin_applicant_url(@applicant), notice: "Applicant was successfully updated." }
          format.json { render :show, status: :ok, location: @applicant }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @applicant.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /applicants/1 or /applicants/1.json
    def destroy
      @applicant.destroy
  
      respond_to do |format|
        format.html { redirect_to applicants_url, notice: "Applicant was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_applicant
        @applicant = Applicant.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def applicant_params
        params.require(:applicant).permit(:user_id, :salary, :hybrid_option, :rails_level, :test_score, perks: [])
      end

      def search_and_orders_params
        params.permit(:sort_by, :sort_order, :search)
      end
  end
  
end