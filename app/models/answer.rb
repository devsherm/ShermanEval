class Answer < ApplicationRecord
  belongs_to :applicant
  belongs_to :question

  def fixed_value
    self.value ? self.value.split("\n") : self.value
  end
end
