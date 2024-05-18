class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable,
          :registerable,
          # :recoverable, # requires mailer setup
          :rememberable,
          # :confirmable, # Database is set up, but you need to set up the mailer, if you want
          :validatable

  validates :name, presence: true,
    format: {
      with: /\A[a-zA-Z]+(?:\s[a-zA-Z]+)*\z/,
      message: "can only contain letters"
    },
    exclusion: {
      in: %w(administrator administrator1),
      message: "is not allowed"
    }
end