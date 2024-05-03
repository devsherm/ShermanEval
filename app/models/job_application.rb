class JobApplication < ApplicationRecord
    belongs_to :user
    enum status: { pending: 0, further_consideration: 1, rejected: 2 }
  end