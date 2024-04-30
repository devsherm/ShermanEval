class JobSubmission < ApplicationRecord
    belongs_to :job_application
    enum status: {
        pending: 0,
        reviewed: 1,
        rejected: 2,
        approved: 3 
    }, _prefix: :status
end