class UserApplication < ApplicationRecord
  belongs_to :user

  enum gender: { other: 0, male: 1, female: 2 }

  enum score: { pass: 0, move_forward: 1, follow_up: 2}

  def self.ransackable_associations(auth_object = nil)
    %w[user]  # Allows ransacking through the User model
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[score first_name last_name]
  end
end
