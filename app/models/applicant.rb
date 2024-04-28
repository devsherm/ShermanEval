class Applicant < ApplicationRecord
  belongs_to :user
  enum my_level: { beginner: 0, intermediate: 1, advanced: 2 }
  enum eval: { no_effort: 0, poor_effort: 1, good_effort: 2, follow_up: 3, move_forward: 4 }
end
