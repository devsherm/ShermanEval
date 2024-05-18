class Applicant < ApplicationRecord
  belongs_to :user

  PERKS = %w[laptop ergonomic_office_furniture internet]

  validates :salary, presence: true
  validates :perks, inclusion: { in: PERKS }, allow_nil: true

  enum rails_level: {
    "newbie": "newbie",
    "middle": "middle",
    "senior": "senior"
  }

  before_validation :check_perks

  def category
    return if test_score.blank?
    return "passed" if test_score >= 80
    return "considered" if test_score >= 50

    "fail"
  end

  def self.search_and_orders(params)
    data = where(false)

    data = search(data, params[:search])
    data = order_sanitize_sql(data, params[:sort_by], params[:sort_order])
    
    data
  end

  def self.order_sanitize_sql(data, sort_by, sort_order)
    return data if sort_by.blank? || sort_order.blank?

    target_model = %w[name email].include?(sort_by) ? "users" : "applicants"
      
    data.order(sanitize_sql(["#{target_model}.#{sort_by} #{sort_order}"]))
  end

  def self.search(data, search)
    return data if search.blank?
      
    data.joins(:user).where("users.name ILIKE :search OR users.email ILIKE :search", search: sanitize_sql("%#{search}%"))
  end

  private

  def check_perks
    return if perks.blank?

    self.perks = perks.reject(&:blank?)
  end
end
