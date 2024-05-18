class Applicant < ApplicationRecord
    belongs_to :user
    validates :name, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :experience, presence: true
    validates :availability, presence: true
    serialize :availability, Array
    before_save(:titleize_name, :tally_score)

    scope :most_recent, -> { order(created_at: :desc) }
    scope :highest_score, -> { order(score: :desc) }
    scope :most_available, -> { all.sort_by { |applicant| -applicant.availability.size } }

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
