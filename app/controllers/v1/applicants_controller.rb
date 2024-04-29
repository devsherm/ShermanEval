# app/controllers/v1/applicants_controller.rb

module V1
  class ApplicantsController < ApplicationController
    before_action :authenticate_user!, only: %i[new create index show edit update]
    before_action :set_applicant, only: %i[show edit update]

    # Display all applications
    def index
      @sort_by = params[:sort_by] || 'name' # Default sorting by name

      @applicants = if current_user.admin?
                      case @sort_by
                      when 'name'
                        Applicant.sorted_by_name
                      when 'creation'
                        Applicant.sorted_by_creation
                      when 'category'
                        Applicant.sorted_by_category
                      else
                        Applicant.all
                      end
                    else
                      current_user.applicants
                    end

      render json: @applicants
    end

    # Show a specific application
    def show
      render json: @applicant
    end

    # Display the form for a new application
    def new
      @applicant = Applicant.new
    end

    # Create a new application
    def create
      @applicant = Applicant.new(applicant_params)
      @applicant.user = current_user # Associate with the logged-in user

      if @applicant.save
        redirect_to v1_applicant_path(@applicant), notice: 'Application submitted successfully.'
      else
        render :new
      end
    end

    # Categorize an applicant
    def categorize
      if @applicant.update(category: params[:category])
        redirect_to v1_applicant_path(@applicant), notice: 'Applicant categorized successfully.'
      else
        redirect_to v1_applicant_path(@applicant), alert: 'Error categorizing applicant.'
      end
    end

    # Display the form for editing an application
    def edit; end

    # Update an existing application
    def update
      if @applicant.update(applicant_params)
        redirect_to v1_applicant_path(@applicant), notice: 'Application updated successfully.'
      else
        render :edit
      end
    end

    def notify
      ApplicantMailer.notification(@applicant, params[:message]).deliver_now

      redirect_to v1_applicant_path(@applicant), notice: 'Email sent successfully.'
    end
    # Helper method to find an applicant

    private

    def set_applicant
      @applicant = Applicant.find(params[:id])
    end

    # Strong parameters
    def applicant_params
      params.require(:applicant).permit(
        :name,
        :email,
        :posting_pay,
        :requesting_pay,
        :posting_sched,
        :requesting_class,
        :requesting_schedule,
        :app_host,
        :app_db,
        :rpd_schema,
        :doc_store,
        :my_values,
        :gpt_desc,
        :what_wrong
      )
    end
  end
end
