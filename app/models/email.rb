class Email
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email, :string
  attribute :subject, :string
  attribute :body, :string

  validates :email, presence: true
  validates :subject, presence: true
  validates :body, presence: true

  def save
    ApplicationMailer.send_email(email, subject, body).deliver_now
  end
end
