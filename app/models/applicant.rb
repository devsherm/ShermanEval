class Applicant < ApplicationRecord
    belongs_to :user
    validates :name, presence: true
    validates :experience, presence: true
    validates :availability, presence: true
    serialize :availability, Array
    before_save(:titleize_name, :tally_score)

    private
    def titleize_name
        self.name = self.name.titleize
    end

    def tally_score
        score = 0
        score += 2 if self.experience == 'Some'
        score += 4 if self.experience == 'Lots'
        self.score = score + availability.size
    end
end
