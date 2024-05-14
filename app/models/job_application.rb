class JobApplication < ApplicationRecord
    validates :summary, :experience, :git_competence, :rails_competence, presence: true
    validates :terms, acceptance: true

    STATUS= [
        "Pending",
        "Accepted",
        "Rejected"
    ].freeze

    EXPERIENCE_LEVELS = [
        "Entry Level",
        "Intermediate",
        "Advanced",
        "Manager",
        "Director",
        "Executive"
    ].freeze

    GIT_COMPETENCE_LEVELS = [
        "Very Comfortable",
        "Comfortable",
        "Neutral",
        "Uncomfortable",
        "Very Uncomfortable"
    ].freeze

    RAILS_COMPETENCE_LEVELS = [
        "Very Comfortable",
        "Comfortable",
        "Neutral",
        "Uncomfortable",
        "Very Uncomfortable"
    ].freeze
end