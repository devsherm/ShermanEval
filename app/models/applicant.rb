class Applicant < ApplicationRecord
    belongs_to :user
    validates :name, presence: true
    validates :experience, presence: true
    validates :availability, presence: true
    serialize :availability, Array
    before_save(:titleize_name)

    private
    def titleize_name
        self.name = self.name.titleize
    end
end
