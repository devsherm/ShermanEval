class Applicant < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :applicant_categories
  has_many :categories, through: :applicant_categories 
  accepts_nested_attributes_for :answers, allow_destroy: true
end
