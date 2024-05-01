class User < ApplicationRecord

  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable,
          :registerable,
          :recoverable, # requires mailer setup
          :rememberable,
          # :confirmable, # Database is set up, but you need to set up the mailer, if you want
          :validatable

  has_many :job_submissions, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil) 
    ["email", "name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["job_submissions"]
  end

end
