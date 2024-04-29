class Applicant < ApplicationRecord
  belongs_to :user

  PERKS = %w[laptop ergonomic_office_furniture internet]

  enum rails_level: {
    "newbie": "newbie",
    "middle": "middle",
    "senior": "senior"
  }
end
