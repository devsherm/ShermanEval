class Applicant < ApplicationRecord
    validates :email, presence: true, uniqueness: true, :on => :create
    validates :full_name, presence: { message: "The Full Name field cannot be left blank." }
    validates :how_find, presence: { message: "The 'How did you hear about this position' field must be selected." }, inclusion: { in: %w(Indeed LinkedIn FamilyFriend Other), message: "Please select one of the valid options for the position field."}
    validates :knows_ruby, :knows_rails, :knows_mvc, inclusion: [true, false]
    validates :status, inclusion: ["Application Pending","Reviewed","Not Moving Forward","Requesting Interview","Hired"]
end