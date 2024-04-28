class Applicant < ApplicationRecord
  belongs_to :user

  # Validations
  validates_presence_of :first_name, :last_name, length: { maximum: 50 }

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :age, presence: true,
                  numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :gender, presence: true, inclusion: { in: %w[male female other] }
  validates :skills, presence: true
end
