class UserApplication < ApplicationRecord
  AVAILABLE_SKILLS = ['ruby', 'react', 'vue_js', 'python'].freeze

  before_validation :remove_blank_skills

  belongs_to :user
  validates :user, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :skills, presence: true

  validates :first_name, format: { with: /\A[a-zA-Z\s\-]+\z/, message: "must contain only valid characters (letters, spaces, and hyphens only permitted)" }
  validates :last_name, format: { with: /\A[a-zA-Z\s\-]+\z/, message: "must contain only valid characters (letters, spaces, and hyphens only permitted)" }

  validates :skills, inclusion: { in: AVAILABLE_SKILLS, message: "is not a valid skill" }

  enum gender: { other: 0, male: 1, female: 2 }

  enum score: { pass: 0, move_forward: 1, follow_up: 2}

  def self.ransackable_associations(auth_object = nil)
    %w[user]  # Allows ransacking through the User model
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[score first_name last_name]
  end

  def self.skills_for_select
    AVAILABLE_SKILLS.map do |skill|
      [skill.titleize, skill]
    end
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  private

  def remove_blank_skills
    self.skills = self.skills.reject(&:blank?)
  end
end
