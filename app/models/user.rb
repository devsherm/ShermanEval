class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable,
          :registerable,
          # :recoverable, # requires mailer setup
          :rememberable,
          # :confirmable, # Database is set up, but you need to set up the mailer, if you want
          :validatable

  has_one :applicant, dependent: :destroy
end
