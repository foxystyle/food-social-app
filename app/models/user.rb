class User < ActiveRecord::Base
  # Valid email regex (obviously ~.~")
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save {
    self.email = email.downcase
  }
  # Name
  validates :name,
    presence: true,
    length: {minimum: 2, maximum: 50}
  # Email
  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}
  # Password
  has_secure_password
  validates :password,
    presence: true,
    length: {minimum: 6}


end
