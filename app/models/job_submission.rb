class JobSubmission < ApplicationRecord
    validates :job_application_id, presence:true
    validates :job_submission_data, presence:true
    validates :created_by_id, presence:true
    validates :updated_by_id, presence:true

    belongs_to :job_application
    belongs_to :user, class_name: 'User', foreign_key: 'created_by_id'
    
    enum status: {
        pending: 0,
        reviewed: 1,
        rejected: 2,
        approved: 3 
    }, _prefix: :status

    def self.ransackable_attributes(auth_object = nil) 
        ["created_by_id","status"] 
    end

    def self.ransackable_associations(auth_object = nil)
        ["user"]
    end
end