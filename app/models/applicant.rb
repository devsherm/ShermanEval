class Applicant < ApplicationRecord
  belongs_to :user



  # Sorting Scopes
  scope :sorted_by_name, -> { order(name: :asc) }
  scope :sorted_by_creation, -> { order(created_at: :asc) }
  scope :sorted_by_category, -> { order(category: :asc) }

  # Add necessary validations

  validates :name, :email, :posting_pay, :requesting_pay, :posting_sched, :requesting_class, :requesting_schedule,
            :app_host, :app_db, :rpd_schema, :doc_store, :my_values, :gpt_desc, :what_wrong, presence: true

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Validate inclusion of specific fields within a given set
  validates :requesting_class, inclusion: { in: ['contractor (performance expected, but with maximum flexibility)'] }
  validates :app_host, inclusion: { in: ['Heroku', 'AWS', 'Azure', 'Google Cloud'] }
  validates :app_db, inclusion: { in: %w[MySQL SQLite PostgreSQL MongoDB] }
  validates :doc_store, inclusion: { in: ['AWS', 'Azure', 'Google Cloud'] }
  validates :my_values, inclusion: { in: ['cost of infrastructure', 'speed of development', 'beauty of UI'] }

  # Validate maximum length
  validates :name, :email, length: { maximum: 255 }
  validates :posting_pay, :requesting_pay, :posting_sched, :requesting_schedule, :rpd_schema, :gpt_desc, :what_wrong,
            length: { maximum: 1000 }
  # Ensure categorization values are valid
  validates :category, inclusion: { in: %w[Approved Rejected Pending], allow_nil: true }
end
