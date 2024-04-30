class Applicant < ApplicationRecord
  enum job_type: {
    part_time: 0,
    full_time: 1
  }
  
  belongs_to :user
end
