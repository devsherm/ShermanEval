module ApplicantsHelper
    def get_job_type
        if @applicant.job_type == 'full_time'
            'Full Time'
          else
            'Part Time' 
          end
    end
end
