class JobApplication < ApplicationRecord
    validates :job_title, presence:true
    validates :job_description, presence:true
    validates :job_position, presence:true
    validates :job_department, presence:true

    validates :created_by_id, presence:true
    validates :updated_by_id, presence:true

    belongs_to :user, class_name: 'User', foreign_key: 'created_by_id'
    belongs_to :user, class_name: 'User', foreign_key: 'updated_by_id'

    has_many :job_submissions, dependent: :destroy

    enum status: {
        active: 0,
        pending: 1,
        deleted: 2,
        archived: 3 
    }, _prefix: :status

    enum job_position: {
        software_engineer: 0,
        data_scientist: 1,
        product_manager: 2,
        UX_designer: 3,
        systems_analyst: 4,
        network_engineer: 5
    }, _prefix: :job_position


    enum job_department: {
        engineering: 0,
        marketing: 1,
        finance: 2,
        human_resources: 3,
        sales: 4,
        operations: 5
    }, _prefix: :job_department

    def self.ransackable_attributes(auth_object = nil) 
        ["job_title","job_position","job_department","status"] 
    end

    def self.ransackable_associations(auth_object = nil)
        ["user"]
    end

end