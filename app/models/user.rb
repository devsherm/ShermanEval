class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable,
          :registerable,
          # :recoverable, # requires mailer setup
          :rememberable,
          # :confirmable, # Database is set up, but you need to set up the mailer, if you want
          :validatable

  validates :email, presence: true, format: { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}\z/, message: "Please enter a valid email address." }  
  
  has_many :applications, class_name: "UserApplication"

  def self.ransackable_attributes(auth_object = nil)
    %w[email]
  end
end
