class Questionnaire < ApplicationRecord
  belongs_to :user

  validates :long_text, presence: true, length: { maximum: 10000 }
  validates :short_text, presence: true, length: { maximum: 200 }
  validates :radio_choice, inclusion: { in: ['Hybrid', 'Remote'] }
end
