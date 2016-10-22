class User < ApplicationRecord
  MAX_EMAIL_LENGTH = 254
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  MIN_PASSWORD_LENGTH = 6

  validates :name, presence: true
  validates :email, uniqueness: true,
                    length: { maximum: MAX_EMAIL_LENGTH },
                    format: { with: EMAIL_REGEX }
  validates :password, length: { minimum: MIN_PASSWORD_LENGTH }
  # maximum is set to 72 by default
  # https://github.com/rails/rails/blob/5-0-stable/activemodel/lib/active_model/secure_password.rb
  has_secure_password
end
