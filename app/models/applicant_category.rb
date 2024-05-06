class ApplicantCategory < ApplicationRecord
  belongs_to :category
  belongs_to :applicant
end
