class UserApplication < ApplicationRecord
  belongs_to :user

  enum gender: { other: 0, male: 1, female: 2 }
end
