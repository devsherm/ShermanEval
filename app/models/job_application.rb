class JobApplication < ApplicationRecord
    validates :summary, :experience, :git_competence, :rails_competence, :preferred_contact, presence: true
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

    CONTACT_PREFERENCES = [
        "Email",
        "Phone",
        "No Preference"
    ].freeze
end