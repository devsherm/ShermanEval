class UserApplication < ApplicationRecord
  belongs_to :user
  belongs_to :employer, class_name: 'User'

  validate :employer_is_admin
  validates :my_level, presence: true
  validates :scratch_before, inclusion: { in: [true, false] }
  validates :fav_hobby, presence: true

  enum my_level: { beginner: 0, intermediate: 1, advanced: 2 }
  enum eval: { no_effort: 0, poor_effort: 1, good_effort: 2, follow_up: 3, move_forward: 4 }

  private

  def employer_is_admin
    errors.add(:employer, 'must be an admin') unless employer&.admin?
  end
end
