class Applicant < ApplicationRecord
  belongs_to :user

  PERKS = %w[laptop ergonomic_office_furniture internet]

  validates :salary, presence: true
  validates :perks, inclusion: { in: PERKS }, allow_nil: true

  enum rails_level: {
    "newbie": "newbie",
    "middle": "middle",
    "senior": "senior"
  }

  before_validation :check_perks

  private

  def check_perks
    return if perks.blank?

    self.perks = perks.reject(&:blank?)
  end
end
