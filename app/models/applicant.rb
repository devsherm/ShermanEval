class Applicant < ApplicationRecord
  belongs_to :user

  PERKS = %w[laptop ergonomic_office_furniture internet]

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
