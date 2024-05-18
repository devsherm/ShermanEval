class Applicant < ApplicationRecord
  enum job_type: {
    part_time: 0,
    full_time: 1
  }

  enum status: {
    pending: 0,
    accepted: 1,
    denied: 2
  }
  
  belongs_to :user
end
