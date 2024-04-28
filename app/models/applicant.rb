class Applicant < ApplicationRecord
  belongs_to :user
  enum my_level: { beginner: 0, intermediate: 1, advanced: 2 }
end
