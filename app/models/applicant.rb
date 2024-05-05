class Applicant < ApplicationRecord
  enum status: { pending: 0, approved: 1, denied: 2 }

  belongs_to :user
  
  validates :full_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :experience_summary, presence: true
  validates :primary_backend_language, presence: true
  validates :tech_stack, presence: true
  validates :status, presence: true
  
  def self.ransackable_attributes(auth_object = nil)
    %w[status created_at]
  end

end