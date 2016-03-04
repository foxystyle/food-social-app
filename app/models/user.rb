class User < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save {
    self.email = email.downcase
  }

  validates :name,
    presence: true,
    length: {minimum: 2, maximum: 50}

  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}

end
