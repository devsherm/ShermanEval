class Category < ApplicationRecord
  has_many :applicant_categories
  has_many :applicants, through: :applicant_categories
end
