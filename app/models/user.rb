class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable,
          :registerable,
          # :recoverable, # requires mailer setup
          :rememberable,
          # :confirmable, # Database is set up, but you need to set up the mailer, if you want
          :validatable

  has_many :job_applications, dependent: :destroy, class_name: 'UserApplication', foreign_key: 'user_id'

  has_many :recieved_applications, dependent: :destroy, class_name: 'UserApplication', foreign_key: 'employer_id'
  has_many :applicants, through: :recieved_applications, source: :user
end
