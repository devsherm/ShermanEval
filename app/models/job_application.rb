class JobApplication < ApplicationRecord
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    has_one_attached :resume
    belongs_to :user
    enum status: { pending: 0, further_consideration: 1, rejected: 2 }
  end